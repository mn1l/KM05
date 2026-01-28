import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/core/widgets/rental_card.dart';
import 'package:carsmeelien/models/rental.dart';
import 'package:carsmeelien/services/resource/rentals.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class RentPage extends StatefulWidget {
  const RentPage({super.key});

  @override
  State<RentPage> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  late Future<List<Rental>> _rentalsFuture;

  @override
  void initState() {
    super.initState();
    _rentalsFuture = getMyRentals();
  }

  @override
  void dispose() {
    _rentalsFuture = Future.value([]);
    super.dispose();
  }

  void _refreshRentals() {
    setState(() {
      _rentalsFuture = getMyRentals();
    });
  }

  List<Rental> _filterRentals(List<Rental> rentals, List<String> states) {
    return rentals.where((rental) => states.contains(rental.state)).toList();
  }

  Widget _buildSection(
    String title,
    List<Rental> sectionRentals, {
    double opacity = 1.0,
  }) {
    if (sectionRentals.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(title, style: AppTextStyles.sectionHeader),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Opacity(
                opacity: opacity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: RentalCard(
                    rental: sectionRentals[index],
                    height: 110,
                    onReturn: _refreshRentals,
                  ),
                ),
              );
            }, childCount: sectionRentals.length),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'Auto', style: AppAppBar.titleTextStyle1),
              TextSpan(text: 'Huren', style: AppAppBar.titleTextStyle2),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<Rental>>(
        future: _rentalsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Fout bij laden: ${snapshot.error}'));
          }

          final rentals = snapshot.data ?? [];
          if (rentals.isEmpty) {
            return const Center(child: Text('Geen rentals gevonden'));
          }

          final active = _filterRentals(rentals, ["ACTIVE", "PICKUP"]);
          final reserved = _filterRentals(rentals, ["RESERVED"]);
          final returned = _filterRentals(rentals, ["RETURNED"]);

          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              _buildSection("Actief", active),
              _buildSection("Geplanned", reserved),
              _buildSection("Teruggebracht", returned, opacity: 0.4),
            ],
          );
        },
      ),
    );
  }
}

class MultiSliver extends StatelessWidget {
  final List<Widget> children;
  const MultiSliver({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(slivers: children);
  }
}
