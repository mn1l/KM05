import 'dart:nativewrappers/_internal/vm/lib/ffi_patch.dart';

import 'package:carsmeelien/models/car.dart';
import 'package:carsmeelien/models/customer.dart';
import 'package:carsmeelien/models/inspection.dart';

class Rental {
  final int id;
  final String code;
  final double longitude;
  final double latitude;
  final String fromDate;
  final String toDate;
  final String state;
  
  final Array<Inspection> inspections;
  final Customer customer;
  final Car car;

  Rental({
    required this.id,
    required this.code,
    required this.longitude,
    required this.latitude,
    required this.fromDate,
    required this.toDate,
    required this.state,
    
    required this.inspections,
    required this.customer,
    required this.car,
  });

  factory Rental.fromJson(Map<String, dynamic> json) {
    return Rental(
      id: json['id'] as int,
      code: json['code'] as String,
      longitude: json['longitude'] as double,
      latitude: json['latitude'] as double,
      fromDate: json['fromDate'] as String,
      toDate: json['toDate'] as String,
      state: json['state'] as String,
      inspections: json['inspections'] as Array<Inspection>,
      customer: json['customer'] as Customer,
      car: json['car'] as Car,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'longitude': longitude,
      'latitude': latitude,
      'fromDate': fromDate,
      'toDate': toDate,
      'state': state,
      'inspections': inspections,
      'customer': customer,
      'car': car,
    };
  }
}
