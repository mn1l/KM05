import 'package:carsmeelien/core/widgets/car_image.dart';
import 'package:carsmeelien/models/rental.dart';
import 'package:carsmeelien/pages/rent/navigation_page.dart';
import 'package:carsmeelien/pages/rent/widgets/step_indicator.dart'; 
import 'package:flutter/material.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/pages/rent/widgets/car_info_card.dart';
import 'package:carsmeelien/pages/rent/widgets/expandable_sections.dart';

class RentalInfoPage extends StatelessWidget {
  final Rental rental;
  const RentalInfoPage({super.key, required this.rental});

  bool get _isRentalActive {
    final now = DateTime.now();
    final start = DateTime.parse(rental.fromDate);
    final end = DateTime.parse(rental.toDate);
    
    return now.isAfter(start) && now.isBefore(end.add(const Duration(days: 1)));
  }

  void _startNavigation(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => NavigationPage(rental: rental),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final car = rental.car!;

    return Scaffold(
      appBar: AppAppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'Mijn', style: AppAppBar.titleTextStyle1),
              TextSpan(text: 'Reservering', style: AppAppBar.titleTextStyle2),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            const StepIndicator(currentStep: 0),
            const SizedBox(height: 16),

            Text(
              '${car.brand} ${car.model}',
              textAlign: TextAlign.center,
              style: AppTextStyles.sectionHeader.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 12),

            CarImage(
              base64String: car.picture,
              height: 180,
              width: double.infinity,
              borderRadius: BorderRadius.circular(16),
            ),
            
            const SizedBox(height: 20),
            
            _buildRentalPeriodInfo(),

            const SizedBox(height: 20),
            
            CarInfoCard(car: car),

            if ((car.inspections?.isNotEmpty ?? false) ||
                (car.repairs?.isNotEmpty ?? false)) ...[
              const SizedBox(height: 8),
              ExpandableSections(car: car),
            ],

            const SizedBox(height: 10),

            _buildNavigationButton(context),
            
            if (!_isRentalActive)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "Je kunt de navigatie starten op de dag van verhuur.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRentalPeriodInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _dateColumn("Vanaf", rental.fromDate),
          const Icon(Icons.arrow_forward, color: Colors.grey, size: 16),
          _dateColumn("Tot", rental.toDate),
        ],
      ),
    );
  }

  Widget _dateColumn(String label, String date) {
    final parsedDate = DateTime.parse(date);
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(
          "${parsedDate.day}-${parsedDate.month}-${parsedDate.year}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildNavigationButton(BuildContext context) {
    bool active = _isRentalActive;
    
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: active ? () => _startNavigation(context) : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkBlue,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: active ? 4 : 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.navigation_outlined),
            const SizedBox(width: 8),
            Text(
              active ? 'Start Navigatie' : 'Nog niet beschikbaar',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}