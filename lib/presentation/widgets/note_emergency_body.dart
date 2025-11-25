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
          color: Colors.red,
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "URGENT: B+ Needed",
                    style: AppStyles.styleBold20.copyWith(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "5.3Km away.Manhattan ",
                    style: AppStyles.styleMedium14.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    "Donate Now",
                    style: AppStyles.styleMedium16.copyWith(color: Colors.red),
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
