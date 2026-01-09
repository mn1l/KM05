import 'dart:math';
import 'package:carsmeelien/models/car.dart';
import 'package:carsmeelien/services/resource/cars.dart';
import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/core/widgets/car_card.dart';
import 'package:carsmeelien/pages/favorites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              TextSpan(text: 'Maat', style: AppAppBar.titleTextStyle2),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Favorieten', style: AppTextStyles.sectionHeader),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FavoritesPage()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.darkBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Zie alles'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: FutureBuilder<List<Car>>(
                future: _carsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError || !snapshot.hasData) {
                    return const SizedBox.shrink();
                  }

                  final allCars = snapshot.data!;
                  final favoriteCars = _getRandomCars(allCars, 3);

                  if (favoriteCars.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: favoriteCars.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return CarCard(
                        car: favoriteCars[index],
                        width: 220,
                        imageWidth: 80,
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text('Auto\'s', style: AppTextStyles.sectionHeader),
            const SizedBox(height: 8),
            Expanded(
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

                  final cars = snapshot.data!;

                  if (cars.isEmpty) {
                    return const Center(child: Text('Geen auto’s gevonden'));
                  }

                  return ListView.separated(
                    itemCount: cars.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final car = cars[index];

                      return CarCard(
                        car: car,
                        height: 100,
                        imageWidth: 100,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
