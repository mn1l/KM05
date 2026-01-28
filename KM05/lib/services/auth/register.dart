import 'dart:convert';

import 'package:carsmeelien/services/service.dart' as service;
import 'package:http/http.dart' as http;

final apiUrl = '${service.apiBaseUrl}/api/AM/register';

// Unique function as register endpoint doesn't return any object, so service.post is unusable
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
