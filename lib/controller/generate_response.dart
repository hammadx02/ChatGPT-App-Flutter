// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../constant/api_key.dart';

// Future<String> generateResponse(String prompt) async {
//   const apiKey = apikey;

//   var url = Uri.https("api.openai.com", "/v1/completions");
//   final response = await http.post(
//     url,
//     headers: {
//       'Content-Type': 'application/json',
//       "Authorization": "Bearer $apiKey"
//     },
//     body: json.encode({
//       "model": "gpt-3.5-turbo-0125",
//       "prompt": prompt,
//       'temperature': 0,
//       'max_tokens': 4096,
//       'top_p': 1,
//       'frequency_penalty': 0.0,
//       'presence_penalty': 0.0,
//     }),
//   );

//   if (response.statusCode == 200) {
//     Map<String, dynamic> newresponse = jsonDecode(response.body);
//     return newresponse['choices'][0]['text'];
//   }

//   return {
//     "error": "Cannot catch data",
//     "statusCode": response.statusCode,
//   }.toString();
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constant/api_key.dart';

Future<String> generateResponse(String prompt) async {
  const apiKey = apikey;

  // Use the correct endpoint for chat completions
  var url = Uri.https("api.openai.com", "/v1/chat/completions");

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'model': 'gpt-3.5-turbo-16k',  // Ensure this is the correct model
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
        'temperature': 0,
        'max_tokens': 4096,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> newResponse = jsonDecode(response.body);
      // Adjust based on the response structure
      return newResponse['choices'][0]['message']['content'];
    } else {
      // Return a more detailed error message
      return {
        'error': 'Failed to fetch data',
        'statusCode': response.statusCode,
        'response': response.body,
      }.toString();
    }
  } catch (e) {
    // Handle exceptions
    return 'An error occurred: $e';
  }
}
