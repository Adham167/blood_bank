
import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:flutter/material.dart';

class BloodContentTopView extends StatelessWidget {
  const BloodContentTopView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "BloodConnect",
            style: AppStyles.styleBold24.copyWith(
              color: AppColors.background,
            ),
          ),
          CircleAvatar(
            backgroundColor: AppColors.background.withOpacity(0.2),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_outlined,
                color: AppColors.background,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
