import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'widgets/car_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Nep data
  final List<Map<String, dynamic>> favorites = [
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
  ];

  final List<Map<String, dynamic>> cars = [
    {
      'model': 'Audi A1',
      'location': 'Utrecht',
      'status': 'Bezet',
      'priceCents': 55,
      'imageUrl': 'https://images.unsplash.com/photo-1605559424843-9e4c228bf1c2?w=400&h=300&fit=crop',
    },
    {
      'model': 'VW Golf',
      'location': 'Den Haag',
      'status': 'Beschikbaar',
      'priceCents': 50,
      'imageUrl': 'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?w=400&h=300&fit=crop',
    },
    {
      'model': 'Mercedes A-Class',
      'location': 'Amsterdam',
      'status': 'Beschikbaar',
      'priceCents': 60,
      'imageUrl': 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=400&h=300&fit=crop',
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
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.darkBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Zie alles'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: favorites.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final fav = favorites[index];
                  return CarCard(
                    model: fav['model']!,
                    location: fav['location']!,
                    status: fav['status']!,
                    priceCents: fav['priceCents']!,
                    imageUrl: fav['imageUrl'],
                    width: 220,
                    imageWidth: 80,
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text('Auto\'s', style: AppTextStyles.sectionHeader),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: cars.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final car = cars[index];
                  return CarCard(
                    model: car['model']!,
                    location: car['location']!,
                    status: car['status']!,
                    priceCents: car['priceCents']!,
                    imageUrl: car['imageUrl'],
                    height: 100,
                    imageWidth: 100,
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
