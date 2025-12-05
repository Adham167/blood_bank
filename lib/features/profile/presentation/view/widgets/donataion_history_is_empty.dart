
import 'package:blood_bank/core/app/app_colors.dart';
import 'package:flutter/material.dart';

class DonataionHistoryIsEmpty extends StatelessWidget {
  const DonataionHistoryIsEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          Icon(
            Icons.water_drop_outlined,
            color: Colors.grey[400],
            size: 60,
          ),
          const SizedBox(height: 12),
          Text(
            "No Donations Yet",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Start your journey of saving lives!",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[500]),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // يمكنك إضافة navigation إلى صفحة التبرع
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text("Find Donation Centers"),
          ),
        ],
      ),
    );
  }
}
