import 'dart:convert';
import 'package:carsmeelien/models/rental.dart';
import 'package:carsmeelien/pages/rent/navigation_page.dart';
import 'package:carsmeelien/pages/rent/ongoing_page.dart';
import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';

// TODO NEEDS REWORK TO FIT RENTAL CLASS
class RentalCard extends StatelessWidget {
  final Rental rental;
  final double? width;
  final double? height;
  final double imageWidth;

  const RentalCard({
    super.key,
    required this.rental,
    this.width,
    this.height,
    this.imageWidth = 100,
  });

  void handleNavigate(BuildContext context) {
    Widget? page;

    page = switch (rental.state) {
      "RESERVED" || "PICKUP" => NavigationPage(rental: rental),
      "ACTIVE" => OngoingPage(rental: rental),
      _ => null, // Handle unknown states
    };

    print(rental.state);

    if (page != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page!));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: rental.car!.picture.isNotEmpty
                ? _buildImageWidget()
                : Container(
                    width: imageWidth,
                    height: height ?? double.infinity,
                    color: AppColors.secondary,
                    child: const Icon(Icons.car_rental, color: Colors.white),
                  ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${rental.car!.brand} ${rental.car!.model} ${rental.car!.modelYear}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.euro, size: 16, color: AppColors.darkBlue),
                      const SizedBox(width: 4),
                      Text(
                        '${rental.car!.price} per dag',
                        style: TextStyle(
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.people, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        'Max ${rental.car!.nrOfSeats} personen',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      Text(
                        rental.state == "RETURNED" ? ' Teruggebracht' : ''
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    if (width != null) {
      return SizedBox(
        width: width,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            handleNavigate(context);
          },
          child: card,
        ),
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        handleNavigate(context);
      },
      child: card,
    );
  }

  Widget _buildImageWidget() {
    final picture = rental.car!.picture;
    try {
      final imageBytes = base64Decode(picture);

      return Image.memory(
        imageBytes,
        width: imageWidth,
        height: height ?? double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Failed to decode base64 image: $error');
          return Container(
            width: imageWidth,
            height: height ?? double.infinity,
            color: AppColors.secondary,
            child: const Icon(Icons.image_not_supported, color: Colors.white),
          );
        },
      );
    } catch (e) {
      debugPrint('Error decoding base64 image: $e');
      return Container(
        width: imageWidth,
        height: height ?? double.infinity,
        color: AppColors.secondary,
        child: const Icon(Icons.image_not_supported, color: Colors.white),
      );
    }
  }
}
