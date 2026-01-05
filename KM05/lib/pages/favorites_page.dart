import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(titleText: 'Favorieten'),
      body: const Center(child: Text('Favorites Page')),
    );
  }
}
