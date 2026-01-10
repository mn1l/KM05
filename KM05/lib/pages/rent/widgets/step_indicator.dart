import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';
import 'package:carsmeelien/pages/rent/widgets/step_circle.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;

  const StepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        final isActive = index == currentStep;

        return Row(
          children: [
            StepCircle(
              number: index + 1,
              isActive: isActive,
            ),
            if (index < 3)
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.darkYellow
                      : AppColors.darkBlue,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        );
      }),
    );
  }
}
