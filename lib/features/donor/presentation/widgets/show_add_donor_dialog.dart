import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/utils/widgets/custom_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showAddProductDialog(BuildContext context) {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  String? selectedBloodType;

  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text("Add Product", style: TextStyle(color: AppColors.primary)),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(color: AppColors.primary),
                ),
              ),

              SizedBox(height: 6),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "Phone",
                  labelStyle: TextStyle(color: AppColors.primary),
                ),
              ),
              SizedBox(height: 6),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: "Address",
                  labelStyle: TextStyle(color: AppColors.primary),
                ),
              ),
              SizedBox(height: 6),
              CustomDropdownButton(
                onChanged: (p0) {
                  selectedBloodType = p0;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            child: Text("Cancel", style: TextStyle(color: AppColors.primary)),
          ),
          TextButton(
            onPressed: () {
              // BlocProvider.of<DonorCubit>(context).addDonor(
              //   DonerModel(
              //     name: nameController.text,
              //     bloodType: selectedBloodType!,
              //     phone: phoneController.text,
              //     address: addressController.text,
              //     donationHistory: [],
              //   ),
              // );
              // GoRouter.of(context).pop();
            },
            child: Text("Add", style: TextStyle(color: AppColors.primary)),
          ),
        ],
      );
    },
  );
}
