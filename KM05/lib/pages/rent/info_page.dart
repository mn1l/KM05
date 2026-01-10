import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/models/car.dart';
import 'package:carsmeelien/pages/rent/widgets/step_indicator.dart';	
import 'package:carsmeelien/pages/rent/widgets/car_info_card.dart';
import 'package:carsmeelien/pages/rent/widgets/expandable_sections.dart';
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
            StepIndicator(currentStep: 0),
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

            CarInfoCard(car: car),

            const SizedBox(height: 16),

            if ((car.inspections?.isNotEmpty ?? false) || (car.repairs?.isNotEmpty ?? false))
              ExpandableSections(car: car),

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

