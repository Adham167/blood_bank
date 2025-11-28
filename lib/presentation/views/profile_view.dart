import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/core/utils/custom_text.dart';
import 'package:blood_bank/presentation/views/donor_profile_view.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffafafa),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Information Section ",
                style: AppStyles.styleBold24.copyWith(
                  color: AppColors.secondary,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xfffafafa),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColors.secondbackground,
                    width: 0.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text1: "Name: ", text2: "Adham"),
                      CustomText(text1: "Phone: ", text2: "01030541645"),
                      CustomText(
                        text1: "Email: ",
                        text2: "adhamabdelsalam3040@gmail.com",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              Text(
                "My Donation History ",
                style: AppStyles.styleBold24.copyWith(
                  color: AppColors.secondary,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColors.secondbackground,
                    width: 0.5,
                  ),
                ),
                child: DonationHistory(),
              ),
              SizedBox(height: 16),
              Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
