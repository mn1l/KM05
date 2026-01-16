import 'dart:convert';

import 'package:carsmeelien/models/account.dart';
import 'package:carsmeelien/services/auth/token.dart';
import 'package:http/http.dart' as http;

const apiUrl = 'http://192.168.178.42:8080/api/account';

Future<Account> getAccountDetails() async {
  TokenService tokenService = TokenService();
  if (!await tokenService.isAuthorized()) {
    throw Exception('Not authenticated');
  }

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await tokenService.getToken()}',
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Getting account details failed: ${response.statusCode}');
  }

  final Map<String, dynamic> decoded =
      jsonDecode(response.body) as Map<String, dynamic>;

  return Account.fromJson(decoded);
}
