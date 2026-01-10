import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/pages/rent/widgets/info_row.dart';
import 'package:carsmeelien/models/car.dart';

class CarInfoCard extends StatelessWidget {
  final Car car;

  const CarInfoCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            InfoRow(label: 'Kenteken', value: car.licensePlate),
            InfoRow(label: 'Brandstof', value: car.fuel),
            InfoRow(label: 'Motorinhoud', value: car.engineSize.toString()),
            InfoRow(label: 'Aantal zitplaatsen', value: car.nrOfSeats.toString()),
            InfoRow(label: 'Carrosserie', value: car.body),
            InfoRow(label: 'Prijs/dag', value: '€${car.price.toStringAsFixed(2)}', isBold: true),
          ],
        ),
      ),
    );
  }
}