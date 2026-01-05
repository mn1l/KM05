import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key, required this.title});

  final String title;

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(titleText: widget.title),
      body: const Center(child: Text('Favorites Page')),
    );
  }
}
