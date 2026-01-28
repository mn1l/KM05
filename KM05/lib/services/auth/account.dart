import 'package:carsmeelien/config/api_keys.dart';
import 'package:carsmeelien/models/account.dart';
import 'package:carsmeelien/services/service.dart' as service;

final apiUrl = '${ApiKeys.apiBaseUrl}/api/account';

Future<Account> getAccountDetails() async {
  return await service.get<Account>(apiUrl, Account.fromJson);
}
