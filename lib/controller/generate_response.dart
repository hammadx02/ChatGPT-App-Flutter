import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> generateResponse(String prompt) async {
  var url = Uri.https('api.openai.com', '/v1/completions');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer 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'
    },
    body: json.encode(
      {
        'model': 'text-davinci-003',
        'prompt': prompt,
        'temperature': 0,
        'max_tokens': 2000,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
      },
    ),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> newresponse = jsonDecode(response.body.toString());
    return newresponse['choices'][0]['text'];
  }
  return {
    'error': 'Cannot catch data',
    'statusCode': response.statusCode,
  }.toString();
}
