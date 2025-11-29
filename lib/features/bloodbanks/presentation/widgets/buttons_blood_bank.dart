import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:flutter/material.dart';

class ButtonsBloodBank extends StatelessWidget {
  const ButtonsBloodBank({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 30,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(width: 1, color: Colors.black),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.call),
                SizedBox(width: 6),
                Text(
                  "Call",
                  style: AppStyles.styleBold15.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16),
        Container(
          height: 30,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.primary,
          ),
          child: Center(
            child: Text(
              "Directions",
              style: AppStyles.styleBold15.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
