import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/core/widgets/car_card.dart';

class RentHistoryPage extends StatefulWidget {
  const RentHistoryPage({super.key});

  @override
  State<RentHistoryPage> createState() => _RentHistoryPageState();
}

class _RentHistoryPageState extends State<RentHistoryPage> {
  // Nep data
  final List<Map<String, dynamic>> rentHistory = [
    {
      'brand': 'Volkswagen',
      'model': 'VW Golf',
      'location': 'Den Haag',
      'status': 'Voltooid',
      'priceCents': 50,
      'imageUrl': 'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?w=400&h=300&fit=crop',
    },
    {
      'brand': 'Volkswagen',
      'model': 'Mercedes A-Class',
      'location': 'Amsterdam',
      'status': 'Voltooid',
      'priceCents': 60,
      'imageUrl': 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=400&h=300&fit=crop',
    },
    {
      'brand': 'Volkswagen',
      'model': 'Tesla Model 3',
      'location': 'Amsterdam',
      'status': 'Voltooid',
      'priceCents': 50,
      'imageUrl': 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=400&h=300&fit=crop',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'Huur', style: AppAppBar.titleTextStyle1),
              TextSpan(text: 'Geschiedenis', style: AppAppBar.titleTextStyle2),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: rentHistory.isEmpty
            ? const Center(
                child: Text(
                  'Geen huurgeschiedenis gevonden',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.separated(
                itemCount: rentHistory.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final car = rentHistory[index];
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
