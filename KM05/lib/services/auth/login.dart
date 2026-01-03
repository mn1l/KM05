import 'dart:convert';

import 'package:http/http.dart' as http;

const apiUrl = 'http://192.168.178.42:8080/api/authenticate';

Future<String> login(String username, String password) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{'Content-Type': 'application/json'},
    body: jsonEncode(<String, dynamic>{
      "username": username,
      "password": password,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Login failed: ${response.statusCode}');
  }

  final Map<String, dynamic> data = jsonDecode(response.body);

  final String? idToken = data['id_token'];

  if (idToken == null || idToken.isEmpty) {
    throw Exception('Response incomplete: Missing or invalid idToken');
  }

  return idToken;
}
