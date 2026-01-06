import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';

class CarCard extends StatelessWidget {
  final String model;
  final String location;
  final String status;
  final int priceCents;
  final String? imageUrl;
  final double? width;
  final double? height;
  final double imageWidth;

  const CarCard({
    super.key,
    required this.model,
    required this.location,
    required this.status,
    required this.priceCents,
    this.imageUrl,
    this.width,
    this.height,
    this.imageWidth = 100,
  });

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
            child: imageUrl != null
                ? Image.network(
                    imageUrl!,
                    width: imageWidth,
                    height: height ?? double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: imageWidth,
                        height: height ?? double.infinity,
                        color: AppColors.secondary,
                        child: const Icon(Icons.image_not_supported, color: Colors.white),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: imageWidth,
                        height: height ?? double.infinity,
                        color: AppColors.secondary,
                        child: const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      );
                    },
                  )
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
                  Text(model, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(location),
                  Text(status),
                  Text("€${(priceCents / 100).toStringAsFixed(2).replaceAll('.', ',')}/min"),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    if (width != null) {
      return SizedBox(width: width, child: card);
    }

    return card;
  }
}

