import 'dart:convert';

import 'package:carsmeelien/models/rental.dart';
import 'package:carsmeelien/services/resource/customer.dart';
import 'package:carsmeelien/services/service.dart' as service;

final apiUrl = '${service.apiBaseUrl}/api/rentals';

Future<List<Rental>> getRentals() async {
  return await service.getList<Rental>(apiUrl, Rental.fromJson);
}

Future<List<Rental>> getRentalsByState(String state) async {
  final allRentals = await getRentals();
  return allRentals.where((rental) => rental.state == state).toList();
}

Future<List<Rental>> getMyRentals() async {
  // Omdat bij customer.rentals geen data is over de auto
  List<Rental> result = [];

  final customer = await getMe();

  result = await Future.wait(
    customer.rentals.map((rental) async {
      return await getRentalById(rental.id);
    }),
  );

  return result;
}

Future<Rental> getRentalById(int id) async {
  return await service.get<Rental>('$apiUrl/$id', Rental.fromJson);
}

Future<Rental> updateRentalState(int rentalId, String state) async {
  return await service.patch<Rental>(
    '$apiUrl/$rentalId',
    Rental.fromJson,
    jsonEncode({'id': rentalId, 'state': state}),
  );
}

Future<Rental> updateRentalLocation(int rentalId, double longitude, double latitude) async {
  return await service.patch<Rental>(
    '$apiUrl/$rentalId',
    Rental.fromJson,
    jsonEncode({'id': rentalId, 'longitude': longitude, 'latitude': latitude}),
  );
}

Future<Rental> postRental(Rental rental) async {
  return await service.post<Rental>(
    apiUrl,
    Rental.fromJson,
    jsonEncode(rental.toJson()),
  );
}
