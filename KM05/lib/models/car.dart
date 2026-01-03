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
  final String? inspections;
  final String? repairs;
  final String? rentals;

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
    return Car(
      id: json['id'] as int,
      brand: json['brand'] as String,
      model: json['model'] as String,
      picture: json['picture'] as String,
      fuel: json['fuel'] as String,
      options: json['options'] as String,
      licensePlate: json['license_plate'] as String,
      engineSize: json['engine_size'] as int,
      modelYear: json['model_year'] as int,
      since: json['since'] as String,
      price: json['price'] as int,
      nrOfSeats: json['nr_of_seats'] as int,
      body: json['body'] as String,
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      inspections: json['inspections'] as String?,
      repairs: json['repairs'] as String?,
      rentals: json['rentals'] as String?,
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
      'license_plate': licensePlate,
      'engine_size': engineSize,
      'model_year': modelYear,
      'since': since,
      'price': price,
      'nr_of_seats': nrOfSeats,
      'body': body,
      'longitude': longitude,
      'latitude': latitude,
      'inspections': inspections,
      'repairs': repairs,
      'rentals': rentals,
    };
  }
}
