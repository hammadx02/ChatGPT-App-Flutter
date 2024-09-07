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
//       "model": "text-davinci-003",
//       "prompt": prompt,
//       'temperature': 0,
//       'max_tokens': 2000,
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

  var url = Uri.https("api.openai.com", "/v1/completions");

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'model': 'text-davinci-003',
        'prompt': prompt,
        'temperature': 0,
        'max_tokens': 2000,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
      }),
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      Map<String, dynamic> newResponse = jsonDecode(response.body);
      return newResponse['choices'][0]['text'];
    } else {
      // Log the full response body for better error handling
      print('Error: ${response.statusCode}');
      print('Response body: ${response.body}');
      return 'Error ${response.statusCode}: ${response.body}';
    }
  } catch (e) {
    // Handle any other exceptions
    print('Exception caught: $e');
    return 'An error occurred: $e';
  }
}