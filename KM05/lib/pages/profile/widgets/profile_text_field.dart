import 'package:flutter/material.dart';
import 'package:carsmeelien/core/theme.dart';

class ProfileTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscureText;

  const ProfileTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      style: const TextStyle(color: AppColors.darkBlue), 
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.darkBlue), 
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.darkBlue.withOpacity(0.6)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.darkBlue), 
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.darkYellow, width: 2), 
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      cursorColor: AppColors.darkBlue,
    );
  }
}
