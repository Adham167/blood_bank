
import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/features/donor/data/donation_model.dart';
import 'package:blood_bank/features/donor/presentation/widgets/donation_history.dart';
import 'package:flutter/material.dart';

class DonationStatistics extends StatelessWidget {
  const DonationStatistics({
    super.key,
    required this.totalDonations,
    required this.nextDonationDate,
    required this.donations,
  });

  final int totalDonations;
  final DateTime nextDonationDate;
  final List<DonationModel> donations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 📊 Donation Statistics
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "$totalDonations",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    "Total Donations",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Container(
                height: 40,
                width: 1,
                color: Colors.grey[300],
              ),
              Column(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Next: ${nextDonationDate.day}/${nextDonationDate.month}",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
    
        // 🗂️ Donation History List
        DonationHistory(donationHistory: donations),
      ],
    );
  }
}
