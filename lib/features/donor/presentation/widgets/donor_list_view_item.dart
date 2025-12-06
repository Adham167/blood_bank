import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_router.dart';
import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:blood_bank/features/donor/presentation/widgets/custom_circle_avatar.dart';
import 'package:blood_bank/features/donor/presentation/widgets/custom_sub_title.dart';
import 'package:blood_bank/features/donor/presentation/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DonorListViewItem extends StatelessWidget {
  const DonorListViewItem({super.key, required this.donor, required this.isMe});

  final bool isMe;
  final UserModel donor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: isMe ? Colors.green.shade50 : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        onTap:
            () => GoRouter.of(
              context,
            ).push(AppRouter.kDonorProfileView, extra: donor),
        leading: CustomCircleAvatar(isMe: isMe, donor: donor),
        title: CustomTitle(donor: donor, isMe: isMe),
        subtitle: CustomSubTitle(donor: donor),
        trailing:
            isMe
                ? const Icon(Icons.person, color: Colors.green)
                : IconButton(
                  onPressed: () {
                    // Call action
                  },
                  icon: const Icon(Icons.call, color: AppColors.primary),
                ),
      ),
    );
  }
}
