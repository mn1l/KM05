import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/core/utils/formatters.dart';
import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/core/widgets/car_image.dart';
import 'package:carsmeelien/models/rental.dart';
import 'package:carsmeelien/pages/rent/inspection-form_page.dart';
import 'package:carsmeelien/pages/rent/widgets/step_indicator.dart';
import 'package:flutter/material.dart';

class OngoingPage extends StatefulWidget {
  final Rental rental;
  const OngoingPage({super.key, required this.rental});

  @override
  State<OngoingPage> createState() => _OngoingPageState();
}

class _OngoingPageState extends State<OngoingPage> {
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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              const StepIndicator(currentStep: 2),
              const SizedBox(height: 12),

              Text(
                'Actieve huur',
                style: AppTextStyles.sectionHeader.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 12),
              
              Expanded(
                child: ListView(
                  children: [
                    _buildCarStatusCard(),
                    const SizedBox(height: 16),
                    _buildInfoCard(),
                    const SizedBox(height: 16),
                    _buildHelpSection(),
                  ],
                ),
              ),

              // Bottom Button Section
              _buildEndTripButton(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarStatusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12, 
            blurRadius: 10, 
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          CarImage(
            base64String: widget.rental.car?.picture,
            width: double.infinity,
            height: 140,
            borderRadius: BorderRadius.circular(12), 
          ),
          const SizedBox(height: 16),
          Text(
            "${widget.rental.car?.brand} ${widget.rental.car?.model}",
            style: const TextStyle(
              fontSize: 22, 
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(height: 4),
          // Status label removed as requested
          
          const Divider(height: 32),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildQuickAction(Icons.lock_open, "Openen"),
              _buildQuickAction(Icons.lock, "Sluiten"),
              _buildQuickAction(Icons.lightbulb_outline, "Lichten"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.darkBlue.withOpacity(0.1),
          child: Icon(icon, color: AppColors.darkBlue),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time, color: AppColors.darkBlue, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 15),
                children: [
                  const TextSpan(
                    text: "Inleveren voor: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: AppFormatters.date(widget.rental.toDate),
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBlue.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.help_outline, color: AppColors.darkBlue, size: 20),
              const SizedBox(width: 8),
              Text(
                "Hulp nodig?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBlue.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "Neem contact op met de Hanze klantenservice:",
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          
          _buildContactItem(Icons.phone_outlined, "050 - 595 5555"),
          const SizedBox(height: 4),
          
          _buildContactItem(Icons.email_outlined, "info@org.hanze.nl"),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.darkBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildEndTripButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 179, 36, 36),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => InspectionFormPage(rental: widget.rental),
            ),
          );
        },
        child: const Text(
          'Rit stopzetten',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}