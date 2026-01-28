import 'package:carsmeelien/models/inspection.dart';
import 'package:carsmeelien/models/rental.dart';
import 'package:carsmeelien/models/repair.dart';

class Car {
  final int id;
  final String brand;
  final String model;
  final String picture;
  final String fuel;
  final String options;
  final String licensePlate;
  final int engineSize;
  final int modelYear;
  final String since;
  final int price;
  final int nrOfSeats;
  final String body;
  final double longitude;
  final double latitude;
  final List<Inspection>? inspections;
  final List<Repair>? repairs;
  final List<Rental>? rentals;

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.picture,
    required this.fuel,
    required this.options,
    required this.licensePlate,
    required this.engineSize,
    required this.modelYear,
    required this.since,
    required this.price,
    required this.nrOfSeats,
    required this.body,
    required this.longitude,
    required this.latitude,
    this.inspections,
    this.repairs,
    this.rentals,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    final inspectionsJson = json['inspections'] as List<dynamic>?;
    final repairsJson = json['repairs'] as List<dynamic>?;
    final rentalsJson = json['rentals'] as List<dynamic>?;

    String picture = (json['picture'] as String?) ?? '';

    return Car(
      id: (json['id'] as num?)?.toInt() ?? 0,
      brand: json['brand'] as String,
      model: json['model'] as String,
      picture: picture,
      fuel: json['fuel'] as String,
      options: json['options'] as String,
      licensePlate: json['licensePlate'] as String,
      engineSize: (json['engineSize'] as num?)?.toInt() ?? 0,
      modelYear: (json['modelYear'] as num?)?.toInt() ?? 0,
      since: json['since'] as String,
      price: (json['price'] as num?)?.toInt() ?? 0,
      nrOfSeats: (json['nrOfSeats'] as num?)?.toInt() ?? 0,
      body: json['body'] as String,
      longitude: (json['longitude'] as num).toDouble() ?? 0.0,
      latitude: (json['latitude'] as num).toDouble() ?? 0.0,
      inspections: inspectionsJson != null
              ? inspectionsJson.map((e) => Inspection.fromJson(e as Map<String, dynamic>)).toList()
              : [],
      repairs: repairsJson != null
              ? repairsJson.map((e) => Repair.fromJson(e as Map<String, dynamic>)).toList()
              : [],
      rentals: rentalsJson != null
              ? rentalsJson.map((e) => Rental.fromJson(e as Map<String, dynamic>)).toList()
              : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'picture': picture,
      'fuel': fuel,
      'options': options,
      'licensePlate': licensePlate,
      'engineSize': engineSize,
      'modelYear': modelYear,
      'since': since,
      'price': price,
      'nrOfSeats': nrOfSeats,
      'body': body,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
