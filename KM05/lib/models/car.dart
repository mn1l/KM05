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

    // Handle picture field - might be null, base64 data, or a URL
    String picture = (json['picture'] as String?) ?? '';
    
    // Helper function to check if string looks like base64 (contains only base64 chars and is long)
    bool _isBase64String(String str) {
      if (str.isEmpty || str.length < 100) return false;
      
      // Common base64 image headers:
      // JPEG: /9j/ or 9j/ (base64 encoding of JPEG file header)
      // PNG: iVBORw0KGgo (base64 encoding of PNG file header)
      if (str.startsWith('/9j/') || str.startsWith('9j/') || str.startsWith('iVBORw0KGgo')) {
        return true;
      }
      
      // Base64 contains only: A-Z, a-z, 0-9, +, /, =, and possibly whitespace/newlines
      // Check if it's mostly base64 characters and is long enough
      final base64Pattern = RegExp(r'^[A-Za-z0-9+/=\s\n\r]+$');
      return base64Pattern.hasMatch(str) && str.length > 500;
    }
    
    // Check if picture is base64 data
    final isBase64Data = picture.startsWith('data:image/') || _isBase64String(picture);
    
    // If picture is a relative path (starts with /), construct full URL with base API URL
    // Only do this if it's NOT base64 data and NOT already a full URL
    if (picture.isNotEmpty && 
        !isBase64Data && 
        !picture.startsWith('http://') && 
        !picture.startsWith('https://') &&
        picture.startsWith('/')) {
      const baseUrl = 'http://192.168.178.42:8080';
      picture = '$baseUrl$picture';
    }

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
      inspections:
          inspectionsJson
              ?.map((e) => Inspection.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [], // default empty list if null
      repairs:
          repairsJson
              ?.map((e) => Repair.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [], // default empty list if null
      rentals:
          rentalsJson
              ?.map((e) => Rental.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [], // default empty list if null
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
