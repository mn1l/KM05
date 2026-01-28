import 'package:carsmeelien/models/car.dart';
import 'package:carsmeelien/pages/login_page.dart';
import 'package:carsmeelien/services/auth/token.dart';
import 'package:carsmeelien/services/resource/cars.dart';
import 'package:carsmeelien/services/storage/favorites.dart';
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
  late Future<List<Car>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _carsFuture = getAvailableCars();
    _favoritesFuture = getFavorites();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuth();
    });
  }

  void _refreshData() {
    setState(() {
      _favoritesFuture = getFavorites();
    });
  }

  @override
  void dispose() {
    _carsFuture = Future.value([]);
    _favoritesFuture = Future.value([]);
    super.dispose();
  }

  Future<void> _checkAuth() async {
    bool authorized = await tokenService.isAuthorized();
    if (authorized) {
      setState(() => _isLoading = false);
    } else if (mounted) {
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
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FavoritesPage()),
                    );
                    _refreshData();
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
                future: _favoritesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final favoriteCars = snapshot.data ?? [];

                  if (favoriteCars.isEmpty) {
                    return const Center(
                      child: Text(
                        'Geen favorieten opgeslagen',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    );
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
                        onFavoriteChange: _refreshData,
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
                      child: Text('Fout bij laden: ${snapshot.error}'),
                    );
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
          ],
        ),
      ),
    );
  }
}
