import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';

class CarImage extends StatelessWidget {
  final String? base64String;
  final double width;
  final double? height;
  final BorderRadius? borderRadius;

  const CarImage({
    super.key,
    this.base64String,
    required this.width,
    this.height,
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(16),
      bottomLeft: Radius.circular(16),
    ),
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      width: width,
      height: height ?? double.infinity,
      color: AppColors.secondary,
      child: const Icon(Icons.car_rental, color: Colors.white, size: 40),
    );

    if (base64String != null && base64String!.isNotEmpty) {
      try {
        final imageBytes = base64Decode(base64String!);
        content = Image.memory(
          imageBytes,
          width: width,
          height: height ?? double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => content,
        );
      } catch (e) {
        debugPrint('Error decoding base64: $e');
      }
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: content,
    );
  }
}