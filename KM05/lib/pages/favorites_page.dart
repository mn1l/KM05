import 'package:carsmeelien/services/storage/favorites.dart';
import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/core/widgets/car_card.dart';
import 'package:carsmeelien/models/car.dart';

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
    _carsFuture = getFavorites();
  }

  void _refreshData() {
    setState(() {
      _carsFuture = getFavorites();
    });
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
              return Center(child: Text('Fout bij laden: ${snapshot.error}'));
            }

            final cars = snapshot.data ?? [];

            if (cars.isEmpty) {
              return const Center(child: Text('Geen auto’s gevonden'));
            }

            return ListView.separated(
              itemCount: cars.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return CarCard(
                  car: cars[index],
                  height: 100,
                  imageWidth: 100,
                  onFavoriteChange: _refreshData,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
