import 'dart:convert';

import 'package:carsmeelien/models/car.dart';
import 'package:carsmeelien/services/resource/rentals.dart';
import 'package:carsmeelien/services/service.dart' as service;

final apiUrl = '${service.apiBaseUrl}/api/cars';

Future<Car> getCar(int id) async {
  return await service.get<Car>('$apiUrl/$id', Car.fromJson);
}

Future<List<Car>> getCars() async {
  return await service.getList<Car>(apiUrl, Car.fromJson);
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

Future<Car> updateCarLocation(int id, double longitude, double latitude) async {
  return await service.patch(
    '$apiUrl/$id',
    Car.fromJson,
    jsonEncode({'id': id, 'longitude': longitude, 'latitude': latitude}),
  );
}
