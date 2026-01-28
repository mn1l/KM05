import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:carsmeelien/models/car.dart';

const String favKey = 'full_fav_cars';
const _storage = FlutterSecureStorage();

Future<List<Car>> getFavorites() async {
  String? jsonString = await _storage.read(key: favKey);

  if (jsonString != null) {
    List<dynamic> decodedList = jsonDecode(jsonString);
    return decodedList.map((item) => Car.fromJson(item)).toList();
  }
  return [];
}

Future<void> addFavorite(Car car) async {
  final currentFavorites = await getFavorites();

  if (!currentFavorites.any((item) => item.id == car.id)) {
    currentFavorites.add(car);
    String jsonString = jsonEncode(
      currentFavorites.map((c) => c.toJson()).toList(),
    );
    await _storage.write(key: favKey, value: jsonString);
  }
}

Future<void> removeFavorite(int carId) async {
  List<Car> currentFavorites = await getFavorites();

  currentFavorites.removeWhere((car) => car.id == carId);
  String jsonString = jsonEncode(
    currentFavorites.map((c) => c.toJson()).toList(),
  );
  await _storage.write(key: favKey, value: jsonString);
}
