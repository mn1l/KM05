import 'dart:math';
import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/core/widgets/car_card.dart';
import 'package:carsmeelien/models/car.dart';
import 'package:carsmeelien/services/resource/cars.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<Car>> _carsFuture;

  @override
  void initState() {
    super.initState();
    _carsFuture = getAvailableCars();
  }

  List<Car> _getRandomCars(List<Car> cars, int count) {
    if (cars.length <= count) return cars;
    final random = Random();
    final shuffled = List<Car>.from(cars)..shuffle(random);
    return shuffled.take(count).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'Auto', style: AppAppBar.titleTextStyle1),
              TextSpan(text: 'Favorieten', style: AppAppBar.titleTextStyle2),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Car>>(
          future: _carsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Fout bij laden: ${snapshot.error}',
                  style: AppTextStyles.sectionHeader,
                ),
              );
            }

            final allCars = snapshot.data ?? [];
            final favoriteCars = _getRandomCars(allCars, 3);

            if (favoriteCars.isEmpty) {
              return const Center(
                child: Text(
                  'Geen favorieten gevonden',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.separated(
              itemCount: favoriteCars.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return CarCard(
                  car: favoriteCars[index],
                  height: 100,
                  imageWidth: 100,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
