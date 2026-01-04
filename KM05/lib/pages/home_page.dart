import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Nep data
  final List<Map<String, String>> favorites = [
    {'model': 'Tesla Model 3', 'location': 'Amsterdam', 'status': 'Beschikbaar', 'price': '€0,50/min'},
    {'model': 'BMW i3', 'location': 'Rotterdam', 'status': 'Beschikbaar', 'price': '€0,45/min'},
  ];

  final List<Map<String, String>> cars = [
    {'model': 'Audi A1', 'location': 'Utrecht', 'status': 'Bezet', 'price': '€0,55/min'},
    {'model': 'VW Golf', 'location': 'Den Haag', 'status': 'Beschikbaar', 'price': '€0,50/min'},
    {'model': 'Mercedes A-Class', 'location': 'Amsterdam', 'status': 'Beschikbaar', 'price': '€0,60/min'},
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
                Text('Favorieten', style: TextStyle(color: AppColors.darkBlue, fontSize: 30, fontWeight: FontWeight.bold)),
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
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: favorites.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final fav = favorites[index];
                  return Container(
                    width: 220,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(fav['model']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text(fav['location']!),
                                Text(fav['status']!),
                                Text(fav['price']!),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text('Auto\'s', style: TextStyle(color: AppColors.darkBlue, fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: cars.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final car = cars[index];
                  return Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(car['model']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text(car['location']!),
                                Text(car['status']!),
                                Text(car['price']!),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
