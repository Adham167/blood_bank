import 'package:blood_bank/core/app/app_styles.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
    required this.icon1,
    this.ontap1,
    this.ontap2,
    required this.name1,
    required this.name2,
    required this.icon2,
  });
  final String icon1;
  final VoidCallback? ontap1;
  final VoidCallback? ontap2;
  final String name1;
  final String name2;
  final String icon2;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(), // يعمل التجويف للنص
      notchMargin: 8, // مسافة بين التجويف والزرار
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: ontap1,
              child: Column(
                children: [
                  Image.asset(icon1),
                  SizedBox(height: 8),

                  Text(name1, style: AppStyles.styleRegular12),
                ],
              ),
            ),
            GestureDetector(
              onTap: ontap2,
              child: Column(
                children: [
                  Image.asset(icon2),
                  SizedBox(height: 8),
                  Text(name2, style: AppStyles.styleRegular12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}