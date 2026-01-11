import 'package:carsmeelien/models/car.dart';
import 'package:carsmeelien/pages/login_page.dart';
import 'package:carsmeelien/services/auth/token.dart';
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
  TokenService tokenService = TokenService();
  bool _isLoading = true;

  late Future<List<Car>> _carsFuture;
  // Nep data
  final List<Map<String, dynamic>> favorites = [
    {
      'brand': 'Tesla',
      'model': 'Tesla Model 3',
      'location': 'Amsterdam',
      'status': 'Beschikbaar',
      'priceCents': 50,
      'imageUrl':
          'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=400&h=300&fit=crop',
    },
    {
      'brand': 'BMW',
      'model': 'BMW i3',
      'location': 'Rotterdam',
      'status': 'Beschikbaar',
      'priceCents': 45,
      'imageUrl':
          'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=400&h=300&fit=crop',
    },
  ];

  @override
  void initState() {
    super.initState();
    _carsFuture = getAvailableCars();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuth();
    });
  }

  Future<void> _checkAuth() async {
    // Assuming your tokenService is imported or available
    bool authorized = await tokenService.isAuthorized();

    if (authorized) {
      setState(() => _isLoading = false);
    }
    else if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
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
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: favorites.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final fav = favorites[index];
                  return CarCard(
                    brand: fav['brand'],
                    model: fav['model']!,
                    picture: fav['imageUrl'],
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
                        brand: car.brand,
                        model: car.model,
                        licensePlate: car.licensePlate,
                        picture: car.picture,
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
