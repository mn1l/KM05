import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/models/car.dart';
import 'dart:convert';

class InfoPage extends StatelessWidget {
  final Car car;

  const InfoPage({super.key, required this.car});

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
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _StepIndicator(currentStep: 0),
            const SizedBox(height: 24),

            Text(
              '${car.brand} ${car.model} ${car.modelYear}',
              style: AppTextStyles.sectionHeader,
            ),
            const SizedBox(height: 16),

            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _buildImageWidget(car),
            ),

            const SizedBox(height: 20),

            _CarInfoCard(car: car),

            const SizedBox(height: 16),

            if ((car.inspections?.isNotEmpty ?? false) || (car.repairs?.isNotEmpty ?? false))
              _ExpandableSections(car: car),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  'Huren',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int currentStep;

  const _StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        final isActive = index == currentStep;

        return Row(
          children: [
            _StepCircle(
              number: index + 1,
              isActive: isActive,
            ),
            if (index < 3)
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.darkYellow
                      : AppColors.darkBlue,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        );
      }),
    );
  }
}

class _StepCircle extends StatelessWidget {
  final int number;
  final bool isActive;

  const _StepCircle({
    required this.number,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18,
      backgroundColor:
          isActive ? AppColors.darkYellow : AppColors.darkBlue,
      child: Text(
        number.toString(),
        style: TextStyle(
          color: isActive ? AppColors.darkBlue : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _CarInfoCard extends StatelessWidget {
  final Car car;

  const _CarInfoCard({required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _InfoRow(label: 'Kenteken', value: car.licensePlate),
            _InfoRow(label: 'Brandstof', value: car.fuel),
            _InfoRow(label: 'Motorinhoud', value: car.engineSize.toString()),
            _InfoRow(label: 'Aantal zitplaatsen', value: car.nrOfSeats.toString()),
            _InfoRow(label: 'Carrosserie', value: car.body),
            _InfoRow(label: 'Prijs/dag', value: '€${car.price.toStringAsFixed(2)}', isBold: true),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _InfoRow({required this.label, required this.value, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: AppColors.darkBlue)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? AppColors.darkBlue : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpandableSections extends StatelessWidget {
  final Car car;

  const _ExpandableSections({required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (car.inspections != null && car.inspections!.isNotEmpty)
          ExpansionTile(
            title: const Text('Inspecties', style: TextStyle(fontWeight: FontWeight.bold)),
            children: car.inspections!
                .map((i) => ListTile(title: Text(i.description)))
                .toList(),
          ),
        if (car.repairs != null && car.repairs!.isNotEmpty)
          ExpansionTile(
            title: const Text('Reparaties', style: TextStyle(fontWeight: FontWeight.bold)),
            children: car.repairs!
                .map((r) => ListTile(title: Text(r.description)))
                .toList(),
          ),
      ],
    );
  }
}

Widget _buildImageWidget(Car car) {
  final picture = car.picture;

  if (picture.isEmpty) return _placeholderImage(car);

  try {
    final imageBytes = base64Decode(picture);

    return Image.memory(
      imageBytes,
      width: double.infinity,
      height: 200,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Failed to decode base64 image: $error');
        return _placeholderImage(car);
      },
    );
  } catch (e) {
    debugPrint('Error decoding base64 image: $e');
    return _placeholderImage(car);
  }
}

Widget _placeholderImage(Car car) {
  return Container(
    width: double.infinity,
    height: 200,
    color: AppColors.darkYellow,
    child: const Icon(Icons.directions_car, size: 72, color: Colors.white70),
  );
}

