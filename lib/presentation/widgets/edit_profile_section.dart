
import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:flutter/material.dart';

class EditProfileSection extends StatelessWidget {
  const EditProfileSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.secondbackground,
          width: 0.5,
        ),
        color: Color(0xfffafafa),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              "Edit Profile",
              style: AppStyles.styleBold15.copyWith(
                color: AppColors.secondary,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text(
              "Change Password",
              style: AppStyles.styleBold15.copyWith(
                color: AppColors.secondary,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              "Log Out",
              style: AppStyles.styleBold15.copyWith(
                color: AppColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
