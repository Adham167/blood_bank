
import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.donor,
    required this.isMe,
  });

  final UserModel donor;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            donor.name + (isMe ? " (You)" : ""),
            style: AppStyles.styleBold16.copyWith(
              color: isMe ? Colors.green.shade800 : Colors.black,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            donor.bloodType,
            style: AppStyles.styleBold15.copyWith(
              color: AppColors.background,
            ),
          ),
        ),
      ],
    );
  }
}
