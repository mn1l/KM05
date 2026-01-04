import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';

class CarCard extends StatelessWidget {
  final String model;
  final String location;
  final String status;
  final String price;
  final double? width;
  final double? height;
  final double imageWidth;

  const CarCard({
    super.key,
    required this.model,
    required this.location,
    required this.status,
    required this.price,
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
          Container(
            width: imageWidth,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
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
                  Text(price),
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

