import 'package:carsmeelien/core/widgets/car_list.dart';
import 'package:carsmeelien/core/widgets/filters.dart';
import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/models/car.dart';
import 'package:carsmeelien/services/auth/token.dart';
import 'package:carsmeelien/services/resource/cars.dart';
import 'package:carsmeelien/services/storage/favorites.dart';
import 'package:carsmeelien/pages/login_page.dart';
import 'package:carsmeelien/pages/favorites_page.dart';
import 'package:carsmeelien/core/widgets/car_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TokenService _tokenService = TokenService();
  bool _isLoading = true;
  List<Car> _allCars = [];
  List<Car> _filteredCars = [];
  late Future<List<Car>> _favoritesFuture;

  String _searchQuery = '';
  String _selectedFuel = 'Alle';
  String _selectedBody = 'Alle';

  @override
  void initState() {
    super.initState();
    _favoritesFuture = getFavorites();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    bool authorized = await _tokenService.isAuthorized();
    if (!authorized && mounted) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
      return;
    }
    final cars = await getAvailableCars();
    if (mounted) {
      setState(() {
        _allCars = cars;
        _filteredCars = cars;
        _isLoading = false;
      });
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredCars = _allCars.where((car) {
        final matchesSearch =
            car.brand.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            car.model.toLowerCase().contains(_searchQuery.toLowerCase());

        String fuelValue;
        switch (_selectedFuel) {
          case 'Benzine':
            fuelValue = 'GASOLINE';
            break;
          case 'Diesel':
            fuelValue = 'DIESEL';
            break;
          case 'Hybride':
            fuelValue = 'HYBRID';
            break;
          default:
            fuelValue = 'Alle';
        }

        String bodyValue = _selectedBody.toUpperCase();

        final matchesFuel = _selectedFuel == 'Alle' || car.fuel == fuelValue;
        final matchesBody = _selectedBody == 'Alle' || car.body == bodyValue;

        return matchesSearch && matchesFuel && matchesBody;
      }).toList();
    });
  }

  void _refreshFavorites() {
    setState(() {
      _favoritesFuture = getFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));

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
      body: Column(
        children: [
          FilterSection(
            searchQuery: _searchQuery,
            selectedFuel: _selectedFuel,
            selectedBody: _selectedBody,
            onSearchChanged: (val) {
              _searchQuery = val;
              _applyFilters();
            },
            onFuelChanged: (val) {
              _selectedFuel = val;
              _applyFilters();
            },
            onBodyChanged: (val) {
              _selectedBody = val;
              _applyFilters();
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildFavoritesHeader(),
                  const SizedBox(height: 8),
                  _buildFavoritesList(),
                  const SizedBox(height: 24),
                  CarListSection(
                    cars: _filteredCars,
                    onFavoriteChange: _refreshFavorites,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Favorieten', style: AppTextStyles.sectionHeader),
        TextButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FavoritesPage()),
            );
            _refreshFavorites();
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
    );
  }

  Widget _buildFavoritesList() {
    return SizedBox(
      height: 120,
      child: FutureBuilder<List<Car>>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          final favoriteCars = snapshot.data ?? [];
          if (favoriteCars.isEmpty)
            return const Center(
              child: Text(
                'Geen favorieten',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            );
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: favoriteCars.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) => CarCard(
              car: favoriteCars[index],
              width: 220,
              imageWidth: 80,
              onFavoriteChange: _refreshFavorites,
            ),
          );
        },
      ),
    );
  }
}
