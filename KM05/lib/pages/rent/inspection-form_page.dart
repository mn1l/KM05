import 'dart:convert';
import 'dart:io';

import 'package:carsmeelien/core/widgets/appbar.dart';
import 'package:carsmeelien/models/rental.dart';
import 'package:carsmeelien/pages/main_page.dart';
import 'package:carsmeelien/pages/rent/widgets/step_indicator.dart';
import 'package:carsmeelien/services/resource/cars.dart';
import 'package:carsmeelien/services/resource/inspection.dart';
import 'package:carsmeelien/services/resource/rentals.dart';
import 'package:flutter/material.dart';
import 'package:carsmeelien/models/inspection.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class InspectionFormPage extends StatefulWidget {
  final Rental rental;
  const InspectionFormPage({super.key, required this.rental});

  @override
  State<InspectionFormPage> createState() => _InspectionFormPageState();
}

class _InspectionFormPageState extends State<InspectionFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _odometerController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? _imageFile;
  String _base64Photo = '';
  String _photoType = 'image/jpeg';
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1024,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageFile = File(pickedFile.path);
        _base64Photo = base64Encode(bytes);
      });
    }
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Locatievoorzieningen zijn uitgeschakeld.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Locatietoestemming is geweigerd.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Locatietoestemming is permanent geweigerd.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newInspection = Inspection(
        id: 0,
        code: '',
        odometer: int.parse(_odometerController.text),
        result: '',
        description: _descriptionController.text,
        photo: _base64Photo,
        photoContentType: _photoType,
        completed: DateTime.now().toUtc().toIso8601String(),
      );

      try {
        Position? position = await _determinePosition();
        if (position != null) {
          double _longitude = position.longitude;
          double _latitude = position.latitude;

          await updateRentalLocation(widget.rental.id, _longitude, _latitude);
          await updateCarLocation(widget.rental.car!.id, _longitude, _latitude);
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Instellingen',
              textColor: Colors.white,
              onPressed: () => Geolocator.openAppSettings(),
            ),
          ),
        );
        return;
      }

      await postInspection(newInspection);

      if (!mounted) return;

      await updateRentalState(widget.rental.id, "RETURNED");

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainPage()),
        (route) => false,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Inspectie voltooid!')));
    }
  }

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
            children: [
              const SizedBox(height: 8),
              const StepIndicator(currentStep: 3),
              const SizedBox(height: 12),
              
              Text(
                'Auto Inspectie',
                style: AppTextStyles.sectionHeader.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Voer de huidige staat van de auto in bij inleveren.",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 20),

                        _buildTextField(
                          controller: _odometerController,
                          label: 'Kilometerstand',
                          icon: Icons.speed,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),

                        _buildTextField(
                          controller: _descriptionController,
                          label: 'Opmerkingen / Schade',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 20),

                        // Image Picker Box
                        _buildImagePicker(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),

              _buildSubmitButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon, color: AppColors.darkBlue) : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      validator: (value) => (value == null || value.isEmpty) ? 'Verplicht veld' : null,
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          image: _imageFile != null
              ? DecorationImage(image: FileImage(_imageFile!), fit: BoxFit.cover)
              : null,
        ),
        child: _imageFile == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt_outlined, size: 40, color: AppColors.darkBlue),
                  const SizedBox(height: 8),
                  const Text("Maak een foto van de auto", style: TextStyle(color: Colors.grey)),
                ],
              )
            : null,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
        ),
        onPressed: _submitForm,
        child: const Text(
          'Inspectie Voltooien',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}