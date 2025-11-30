import 'package:blood_bank/core/app/app_colors.dart';
import 'package:flutter/material.dart';

class NextSteps extends StatelessWidget {
  const NextSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.secondbackground, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "What happens next?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "• All donors with matching blood type in your area will be notified",
          ),
          SizedBox(height: 4),
          Text(
            "• Donors can contact you directly using the information provided",
          ),
          SizedBox(height: 4),
          Text("• Your request will be marked as active on the home screen"),
        ],
      ),
    );
  }
}