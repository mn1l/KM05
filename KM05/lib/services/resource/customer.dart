import 'package:carsmeelien/models/customer.dart';
import 'package:carsmeelien/services/service.dart' as service;

final apiUrl = '${service.apiBaseUrl}/api/AM/me';

Future<Customer> getMe() async {
  return await service.get<Customer>(apiUrl, Customer.fromJson);
}
