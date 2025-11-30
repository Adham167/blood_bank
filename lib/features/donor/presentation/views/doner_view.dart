import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/core/utils/custom_button.dart';
import 'package:blood_bank/core/utils/custom_dropdown_button.dart';
import 'package:blood_bank/core/utils/custom_text_field.dart';
import 'package:blood_bank/presentation/widgets/donars_list_view.dart';
import 'package:flutter/material.dart';

class DonerView extends StatelessWidget {
  DonerView({super.key});
  String? selectedBloodType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      appBar: AppBar(
        backgroundColor: const Color(0xfffafafa),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "search Doner",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Blood Type",
                    style: AppStyles.styleBold16.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(height: 8),
                  CustomDropdownButton(
                    onChanged: (value) {
                      selectedBloodType = value;
                    },
                  ),
                  SizedBox(height: 8),
                  Text(
                    "City / Location",
                    style: AppStyles.styleBold16.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(height: 8),
                  CustomTextField(hintText: "Enter City Name"),
                  SizedBox(height: 16),

                  CustomButton(title: "Search Donors"),
                  Divider(),
                  // DonarsListView(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
