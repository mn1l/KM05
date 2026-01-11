import 'dart:convert';

import 'package:carsmeelien/models/rental.dart';
import 'package:carsmeelien/services/auth/token.dart';
import 'package:http/http.dart' as http;

const apiUrl = 'http://192.168.178.42:8080/api/rentals';

Future<List<Rental>> getRentals() async {
  TokenService tokenService = TokenService();
  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {"Authorization": 'Bearer ${await tokenService.getToken()}'},
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to get rentals: ${response.statusCode}');
  }

  final List<dynamic> decoded = jsonDecode(response.body);

  return decoded
      .map((json) => Rental.fromJson(json as Map<String, dynamic>))
      .toList();
}

Future<List<Rental>> getRentalsByState(String state) async {
  final allRentals = await getRentals();
  return allRentals.where((rental) => rental.state == state).toList();
}
