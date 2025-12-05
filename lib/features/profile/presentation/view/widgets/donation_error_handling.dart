
import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/features/donor/presentation/manager/donor_cubit/donor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonationErrorHandling extends StatelessWidget {
  const DonationErrorHandling({super.key, required this.currentUserId, required this.errMessage});

  final String? currentUserId;
  final String errMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red),
      ),
      child: Column(
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 40),
          const SizedBox(height: 8),
          Text(
            "Error loading donations",
            style: TextStyle(
              color: Colors.red[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            errMessage,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red[600]),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              if (currentUserId != null) {
                context.read<DonorCubit>().getDonationHistoryForUser(
                  currentUserId!,
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text("Try Again"),
          ),
        ],
      ),
    );
  }
}
