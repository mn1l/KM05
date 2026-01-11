import 'dart:convert';

import 'package:http/http.dart' as http;

const apiUrl = 'http://192.168.178.42:8080/api/register';

Future<void> register(String login, String firstName, String lastName, String email, String password) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{'Content-Type': 'application/json'},
    body: jsonEncode(<String, dynamic>{"login": login, "firstName": firstName, "lastName": lastName, "password": password, "email": email, "langKey": "NL"}),
  );

  if (response.statusCode != 201) {
    throw Exception('Registration failed: ${response.statusCode}');
  }
}
