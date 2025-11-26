import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:flutter/material.dart';

class NoteEmergencyBody extends StatelessWidget {
  const NoteEmergencyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.primary,
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.error_outline, color: AppColors.background),
                  SizedBox(width: 8),
                  Text(
                    "URGENT: B+ Needed",
                    style: AppStyles.styleBold20.copyWith(color:AppColors.background),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: AppColors.background,
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "5.3Km away.Manhattan ",
                    style: AppStyles.styleMedium14.copyWith(
                      color:AppColors.background,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    "Donate Now",
                    style: AppStyles.styleMedium16.copyWith(color:AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
