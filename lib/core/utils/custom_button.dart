
import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, this.onTap});
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, color: Colors.white),
            SizedBox(width: 6),
            Text(title, style: AppStyles.styleBold15),
          ],
        ),
      ),
    );
  }
}