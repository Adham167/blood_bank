
import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
    required this.isMe,
    required this.donor,
  });

  final bool isMe;
  final UserModel donor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor:
          isMe
              ? AppColors.primary.withOpacity(0.3)
              : AppColors.primary.withOpacity(0.1),
      child: Text(
        donor.name[0],
        style: AppStyles.styleBold18.copyWith(
          color: isMe ? Colors.green : AppColors.primary,
        ),
      ),
    );
  }
}
