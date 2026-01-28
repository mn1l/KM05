import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';

class StepCircle extends StatelessWidget {
  final int number;
  final bool isActive;

  const StepCircle({super.key, required this.number, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: isActive ? AppColors.darkYellow : AppColors.darkBlue,
      child: Text(
        number.toString(),
        style: TextStyle(
          color: isActive ? AppColors.darkBlue : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
