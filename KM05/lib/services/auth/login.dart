import 'dart:convert';

import 'package:carsmeelien/config/api_keys.dart';
import 'package:carsmeelien/services/auth/token.dart';
import 'package:http/http.dart' as http;

final apiUrl = '${ApiKeys.apiBaseUrl}/api/authenticate';

// Could make this use service.post(),
// however service.post always includes the authorization token in its requests which is unavailable at this point.
Future<void> login(String username, String password) async {
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

  TokenService tokenService = TokenService();
  await tokenService.saveToken(idToken);
}
