import 'dart:convert';

import 'package:carsmeelien/config/api_keys.dart';
import 'package:carsmeelien/models/account.dart';
import 'package:carsmeelien/services/service.dart' as service;
import 'package:http/http.dart' as http;

final apiUrl = '${ApiKeys.apiBaseUrl}/api/account';

Future<Account> getAccountDetails() async {
  return await service.get<Account>(apiUrl, Account.fromJson);
}

Future<void> resetPasswordInit(String email) async {
  final response = await http.post(
    Uri.parse('$apiUrl/reset-password/init'),
    body: email,
  );
}
