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

  final List<Inspection>
  inspections; // nullable in JSON, but we default to empty
  final Customer? customer;
  final Car? car;

  Rental({
    required this.id,
    required this.code,
    required this.longitude,
    required this.latitude,
    required this.fromDate,
    required this.toDate,
    required this.state,
    required this.inspections,
    this.customer,
    this.car,
  });

  factory Rental.fromJson(Map<String, dynamic> json) {
    final inspectionsJson = json['inspections'] as List<dynamic>?;

    return Rental(
      id: (json['id'] as num?)?.toInt() ?? 0,
      code: json['code'] as String? ?? '',
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      fromDate: json['fromDate'] as String? ?? '',
      toDate: json['toDate'] as String? ?? '',
      state: json['state'] as String? ?? '',
      inspections: inspectionsJson != null
              ? inspectionsJson.map((e) => Inspection.fromJson(e as Map<String, dynamic>)).toList()
              : [],
      customer: json['customer'] != null
              ? Customer.fromJson(json['customer'] as Map<String, dynamic>)
              : null,
      car: json['car'] != null
              ? Car.fromJson(json['car'] as Map<String, dynamic>)
              : null,
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
      'inspections': inspections.map((e) => e.toJson()).toList(),
      'customer': customer?.toJson(),
      'car': car?.toJson(),
    };
  }
}
