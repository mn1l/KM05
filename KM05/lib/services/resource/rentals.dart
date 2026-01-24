import 'dart:convert';

import 'package:carsmeelien/models/customer.dart';
import 'package:carsmeelien/models/rental.dart';
import 'package:carsmeelien/services/auth/token.dart';
import 'package:carsmeelien/services/resource/customer.dart';
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

Future<Rental> updateRentalState(int rentalId, String state) async {
  TokenService tokenService = TokenService();

  final response = await http.patch(
    Uri.parse('$apiUrl/$rentalId'),
    headers: {
      'Authorization': 'Bearer ${await tokenService.getToken()}',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'id': rentalId, // Most APIs need the ID in the body for a PATCH too
      'state': state,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to get rentals: ${response.statusCode}');
  }

  final Map<String, dynamic> decoded =
      jsonDecode(response.body) as Map<String, dynamic>;

  print(decoded);

  return Rental.fromJson(decoded);
}

Future<Rental> postRental(Rental rental) async {
  TokenService tokenService = TokenService();

  final Map<String, dynamic> data = rental.toJson();
  data.remove('id');

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      "Authorization": 'Bearer ${await tokenService.getToken()}',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to get rentals: ${response.statusCode}');
  }

  final Map<String, dynamic> decoded =
      jsonDecode(response.body) as Map<String, dynamic>;

  return Rental.fromJson(decoded);
}

Future<List<Rental>> getMyRentals() async {
  // Omdat bij customer.rentals geen data is over de auto
  TokenService tokenService = TokenService();
  List<Rental> result = [];

  print('here');
  final customer = await getMe();

  print(jsonEncode(customer));

  result = await Future.wait(
    customer.rentals.map((rental) async {
      return await getRentalById(rental.id);
    }),
  );

  return result;
}

Future<Rental> getRentalById(int id) async {
  TokenService tokenService = TokenService();
  print('here not');

  final response = await http.get(
    Uri.parse('$apiUrl/$id'),
    headers: {'Authorization': 'Bearer ${await tokenService.getToken()}'},
  );

  if (response.statusCode != 200) {
    throw Exception("Failed to get rental: ${response.statusCode}");
  }

  final Map<String, dynamic> decoded =
      jsonDecode(response.body) as Map<String, dynamic>;

  return Rental.fromJson(decoded);
}
