import 'dart:convert';

import 'package:carsmeelien/models/car.dart';
import 'package:carsmeelien/services/auth/token.dart';
import 'package:carsmeelien/services/resource/rentals.dart';
import 'package:http/http.dart' as http;

const apiUrl = 'http://192.168.178.42:8080/api/cars';

Future<Car> getCar(int id) async {
  final response = await http.get(Uri.parse('$apiUrl/$id'));

  if (response.statusCode != 200) {
    throw Exception('Failed to get car: ${response.statusCode}');
  }

  final Map<String, dynamic> decoded =
      jsonDecode(response.body) as Map<String, dynamic>;

  return Car.fromJson(decoded);
}

Future<List<Car>> getCars() async {
  TokenService tokenService = TokenService();
  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {"Authorization": 'Bearer ${await tokenService.getToken()}'},
  );

  if (response.statusCode == 401) {
    tokenService
        .clearToken(); // Means your token is invalid and should be reset.
  }

  if (response.statusCode != 200) {
    throw Exception('Failed to get cars: ${response.statusCode}');
  }

  final List<dynamic> decoded = jsonDecode(response.body);

  return decoded
      .map((json) => Car.fromJson(json as Map<String, dynamic>))
      .toList();
}

Future<List<Car>> getAvailableCars() async {
  final cars = await getCars();

  final reservedRentals = await getRentalsByState("RESERVED");
  final activeRentals = await getRentalsByState("ACTIVE");

  final rentals = reservedRentals + activeRentals;

  cars.map(
    (car) => {
      rentals.map((rental) => {if (rental.car == car) cars.remove(car)}),
    },
  );

  return cars;
}

Future<bool> deleteCar(int id) async {
  return false;
}

Future<Car> updateCarLocation(int id, double longitude, double latitude) async {
  TokenService tokenService = TokenService();

  final response = await http.patch(
    Uri.parse('$apiUrl/$id'),
    headers: {
      'Authorization': 'Bearer ${await tokenService.getToken()}',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({'id': id, 'longitude': longitude, 'latitude': latitude}),
  );

  if (response.statusCode < 200 || response.statusCode > 300) {
    throw Exception('Failed to update car location: ${response.statusCode}');
  }

  final Map<String, dynamic> decoded =
      jsonDecode(response.body) as Map<String, dynamic>;

  return Car.fromJson(decoded);
}

Future<Car> postCar(Car car) async {
  TokenService tokenService = TokenService();

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await tokenService.getToken()}',
    },
    body: car.toJson(),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to post car: ${response.statusCode}');
  }

  final Map<String, dynamic> decoded =
      jsonDecode(response.body) as Map<String, dynamic>;

  return Car.fromJson(decoded);
}
