import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text1, required this.text2});
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: AppStyles.styleBold18.copyWith(color: AppColors.secondary),
          ),
          TextSpan(
            text: text2,
            style: AppStyles.styleRegular13.copyWith(
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
