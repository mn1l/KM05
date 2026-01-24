import 'package:carsmeelien/models/account.dart';
import 'package:carsmeelien/models/rental.dart';

class Customer {
  final int id;
  final int nr;
  final String lastName;
  final String firstName;
  final String from;
  final Account? systemUser;
  final List<Rental> rentals;

  Customer({
    required this.id,
    required this.nr,
    required this.lastName,
    required this.firstName,
    required this.from,
    required this.systemUser,
    required this.rentals,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    final rentalsJson = json['rentals'] as List<dynamic>?;

    return Customer(
      id: (json['id'] as num?)?.toInt() ?? 0,
      nr: (json['nr'] as num?)?.toInt() ?? 0,
      lastName: json['lastName'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      from: json['from'] as String? ?? '',

      systemUser: json['systemUser'] != null
          ? Account.fromJson(json['systemUser'] as Map<String, dynamic>)
          : null,

      rentals: rentalsJson
              ?.map((e) => Rental.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nr': nr,
      'lastName': lastName,
      'firstName': firstName,
      'from': from,
    };
  }
}
