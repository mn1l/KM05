import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/models/rental.dart';
import 'package:carsmeelien/pages/home_page.dart';
import 'package:carsmeelien/pages/rent/inspection-form_page.dart';
import 'package:carsmeelien/pages/rent/ongoing_page.dart';
import 'package:carsmeelien/services/resource/rentals.dart';
import 'package:flutter/material.dart';

class FinishPage extends StatefulWidget {
  final Rental rental;
  const FinishPage({super.key, required this.rental});

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'Auto', style: AppAppBar.titleTextStyle1),
              TextSpan(text: 'Maat', style: AppAppBar.titleTextStyle2),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "U heeft de rit afgerond: ${widget.rental.car!.model}, state: ${widget.rental.state}",
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: SafeArea(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8, // Adds a shadow to stand out from the map
                  ),
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => InspectionFormPage(rental: widget.rental)),
                    );
                  },
                  child: const Text(
                    'Inspectie afronden',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
