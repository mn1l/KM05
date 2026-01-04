import 'dart:convert';

import 'package:carsmeelien/models/car.dart';
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

Future<Car> updateCar(int id, Car car) async {}

Future<bool> deleteCar(int id) async {}

Future<void> patchCar(int id, Car car) async {}

Future<List<Car>> getCars() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode != 200) {
    throw Exception('Failed to get cars: ${response.statusCode}');
  }

  final List<dynamic> decoded = jsonDecode(response.body);

  return decoded
      .map((json) => Car.fromJson(json as Map<String, dynamic>))
      .toList();
}

Future<Car> postCar(Car car) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{'Content-Type': 'application/json'}, // Moet nog access token bij vgm
    body: car.toJson(),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to post car: ${response.statusCode}');
  }
  
  
  final Map<String, dynamic> decoded =
      jsonDecode(response.body) as Map<String, dynamic>;

  return Car.fromJson(decoded);
}
