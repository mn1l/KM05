import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const InfoRow({super.key, required this.label, required this.value, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: AppColors.darkBlue)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? AppColors.darkBlue : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}