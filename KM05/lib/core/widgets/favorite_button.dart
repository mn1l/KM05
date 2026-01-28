import 'package:carsmeelien/services/storage/favorites.dart';
import 'package:flutter/material.dart';
import 'package:carsmeelien/models/car.dart';

class FavoriteButton extends StatefulWidget {
  final Car car;
  final VoidCallback? onChange;

  const FavoriteButton({super.key, required this.car, required this.onChange});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    final favorites = await getFavorites();
    if (mounted) {
      setState(() {
        isFavorite = favorites.any((c) => c.id == widget.car.id);
      });
    }
  }

  Future<void> _toggleFavorite() async {
    if (isFavorite) {
      await removeFavorite(widget.car.id);
    } else {
      await addFavorite(widget.car);
    }

    setState(() {
      isFavorite = !isFavorite;
    });
    widget.onChange?.call();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? 'Toegevoegd aan favorieten'
              : 'Verwijderd van favorieten',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: _toggleFavorite,
    );
  }
}
