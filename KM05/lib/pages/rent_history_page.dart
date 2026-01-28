import 'package:carsmeelien/core/widgets/rental_card.dart';
import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/core/widgets/car_card.dart';
import 'package:carsmeelien/models/rental.dart';
import 'package:carsmeelien/services/resource/rentals.dart';

class RentHistoryPage extends StatefulWidget {
  const RentHistoryPage({super.key});

  @override
  State<RentHistoryPage> createState() => _RentHistoryPageState();
}

class _RentHistoryPageState extends State<RentHistoryPage> {
  late Future<List<Rental>> _rentalsFuture;

  @override
  void initState() {
    super.initState();
    _rentalsFuture = getRentals();
  }

  List<Rental> _getCompletedRentals(List<Rental> rentals) {
    return rentals
        .where((rental) => rental.state.toUpperCase() == 'RETURNED')
        .toList();
  }

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
        child: FutureBuilder<List<Rental>>(
          future: _rentalsFuture,
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

            final allRentals = snapshot.data ?? [];
            final completedRentals = _getCompletedRentals(allRentals);

            if (completedRentals.isEmpty) {
              return const Center(
                child: Text(
                  'Geen huurgeschiedenis gevonden',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.separated(
              itemCount: completedRentals.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final rental = completedRentals[index];
                return RentalCard(rental: rental, height: 100, imageWidth: 100);
              },
            );
          },
        ),
      ),
    );
  }
}
