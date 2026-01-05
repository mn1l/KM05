import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class MyFavoritesPage extends StatefulWidget {
  const MyFavoritesPage({super.key, required this.title});

  final String title;

  @override
  State<MyFavoritesPage> createState() => _MyLoginPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(titleText: widget.title),
      body: const Center(child: Text('Favorites Page')),
    );
  }
}
