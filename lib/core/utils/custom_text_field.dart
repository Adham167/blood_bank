
import 'package:blood_bank/core/app/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.hintText});
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorWidth: 1,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.location_on_outlined,
          color: AppColors.secondary,
          size: 20,
        ),

        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }
}