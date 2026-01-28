import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/core/widgets/rental_card.dart';
import 'package:carsmeelien/models/rental.dart';
import 'package:carsmeelien/services/auth/token.dart';
import 'package:carsmeelien/services/resource/rentals.dart';
import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';

class RentPage extends StatefulWidget {
  const RentPage({super.key});

  @override
  State<RentPage> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  TokenService tokenService = TokenService();
  bool _isLoading = true;

  late Future<List<Rental>> _rentalsFuture;

  @override
  void initState() {
    super.initState();

    _rentalsFuture = getMyRentals();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text('Auto\'s', style: AppTextStyles.sectionHeader),
            const SizedBox(height: 8),
            Expanded(
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

                  final rentals = snapshot.data!;

                  if (rentals.isEmpty) {
                    return const Center(child: Text('Geen auto’s gevonden'));
                  }

                  return ListView.separated(
                    itemCount: rentals.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final rental = rentals[index];

                      return RentalCard(
                        rental: rental,
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
