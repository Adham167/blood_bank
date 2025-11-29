
import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/features/bloodbanks/presentation/widgets/buttons_blood_bank.dart';
import 'package:flutter/material.dart';

class BloodBankItem extends StatelessWidget {
  const BloodBankItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primary.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "New York Blood center",
              style: AppStyles.styleBold20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: AppColors.secondbackground,
                  size: 18,
                ),
                SizedBox(width: 4),
                Text(
                  "310 E 67th st, New York",
                  style: AppStyles.styleMedium14.copyWith(
                    color: AppColors.secondbackground,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_forward,
                  color: AppColors.secondbackground,
                  size: 18,
                ),
                SizedBox(width: 4),
                Text(
                  "6.7km away",
                  style: AppStyles.styleMedium14.copyWith(
                    color: AppColors.secondbackground,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.watch,
                  color: AppColors.secondbackground,
                  size: 18,
                ),
                SizedBox(width: 4),
                Text(
                  "6.7km away",
                  style: AppStyles.styleMedium14.copyWith(
                    color: AppColors.secondbackground,
                  ),
                ),
              ],
            ),
        
            Align(
              alignment: Alignment.center,
              child: ButtonsBloodBank(),
            ),
          ],
        ),
      ),
    );
  }
}
