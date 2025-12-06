
import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_router.dart';
import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShowMoreDonersButton extends StatelessWidget {
  const ShowMoreDonersButton({
    super.key,
    required this.donors,
  });

  final List<UserModel> donors;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push(AppRouter.kDonerView),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "+ ${donors.length - 3} more donors available",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.arrow_forward, color: AppColors.primary, size: 16),
          ],
        ),
      ),
    );
  }
}
