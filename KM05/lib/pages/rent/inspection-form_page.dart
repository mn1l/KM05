import 'dart:convert';
import 'dart:io';

import 'package:carsmeelien/models/rental.dart';
import 'package:carsmeelien/pages/home_page.dart';
import 'package:carsmeelien/services/resource/rentals.dart';
import 'package:flutter/material.dart';
import 'package:carsmeelien/models/inspection.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
        _base64Photo = base64Encode(bytes); // Convert to Base64 for your model
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // 1. Create the Inspection object
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

      await addInspectionToRental(widget.rental.id, newInspection);

      if (!mounted) return;

      await updateRentalState(widget.rental.id, "RETURNED");

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) =>
            false, // This removes all previous screens (Navigation, Form, etc.)
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Inspectie voltooid!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auto Inspectie')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Voer de huidige staat van de auto in",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Odometer Field
              TextFormField(
                controller: _odometerController,
                decoration: const InputDecoration(
                  labelText: 'Kilometerstand',
                  prefixIcon: Icon(Icons.speed),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Voer de km-stand in';
                  if (int.tryParse(value) == null)
                    return 'Voer een geldig getal in';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Opmerkingen / Schadebeschrijving',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Beschrijf de staat van de auto';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[400]!),
                    image: _imageFile != null
                        ? DecorationImage(
                            image: FileImage(_imageFile!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _imageFile == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: AppColors.primary,
                            ),
                            Text("Maak een foto van de auto"),
                          ],
                        )
                      : null,
                ),
              ),

              const SizedBox(height: 30),
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    'Opslaan',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
