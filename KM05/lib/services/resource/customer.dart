import 'package:carsmeelien/config/api_keys.dart';
import 'package:carsmeelien/models/customer.dart';
import 'package:carsmeelien/services/service.dart' as service;

final apiUrl = '${ApiKeys.apiBaseUrl}/api/AM/me';

Future<Customer> getMe() async {
  return await service.get<Customer>(apiUrl, Customer.fromJson);
}
