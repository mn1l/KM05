class Customer {
  final int id;
  final int nr;
  final String lastName;
  final String firstName;
  final String from;
  
  Customer({
    required this.id,
    required this.nr,
    required this.lastName,
    required this.firstName,
    required this.from,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as int,
      nr: json['nr'] as int,
      lastName: json['lastName'] as String,
      firstName: json['firstName'] as String,
      from: json['from'] as String,
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
