import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/core/widgets/car_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  // Nep data
  final List<Map<String, dynamic>> favoriteCars = [
    {
      'model': 'Tesla Model 3',
      'location': 'Amsterdam',
      'status': 'Beschikbaar',
      'priceCents': 50,
      'imageUrl': 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=400&h=300&fit=crop',
    },
    {
      'model': 'BMW i3',
      'location': 'Rotterdam',
      'status': 'Beschikbaar',
      'priceCents': 45,
      'imageUrl': 'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=400&h=300&fit=crop',
    },
    {
      'model': 'Audi A1',
      'location': 'Utrecht',
      'status': 'Bezet',
      'priceCents': 55,
      'imageUrl': 'https://images.unsplash.com/photo-1605559424843-9e4c228bf1c2?w=400&h=300&fit=crop',
    },
  ];

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
        child: favoriteCars.isEmpty
            ? const Center(
                child: Text(
                  'Geen favorieten gevonden',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.separated(
                itemCount: favoriteCars.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final car = favoriteCars[index];
                  return CarCard(
                    brand: car['brand'],
                    model: car['model']!,
                    picture: car['picture'],
                    height: 100,
                    imageWidth: 100,
                  );
                },
              ),
      ),
    );
  }
}
