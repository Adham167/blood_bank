import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/core/constants/show_snack_bar.dart';
import 'package:blood_bank/core/utils/widgets/custom_dropdown_button.dart';
import 'package:blood_bank/features/emergency/data/models/emergency_model.dart';
import 'package:blood_bank/features/emergency/presentation/manager/emergency_cubit/emergency_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BloodRequestForm extends StatelessWidget {
  BloodRequestForm({super.key});

  String? selectedBloodType;
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xfffafafa),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Blood Request Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Blood Type Dropdown
          const Text("Blood Type Needed *"),
          const SizedBox(height: 6),
          CustomDropdownButton(
            onChanged: (data) {
              selectedBloodType = data;
            },
          ),

          const SizedBox(height: 16),
          // Location Field
          const Text("Your Location"),
          const SizedBox(height: 6),

          TextField(
            controller: _addressController,
            decoration: const InputDecoration(labelText: "Enter Your Location"),
          ),

          const SizedBox(height: 16),
          // Additional Notes
          const Text("Additional Notes (Optional)"),
          const SizedBox(height: 6),
          TextField(
            controller: _notesController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText:
                  "Provide any additional details about your emergency...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Send Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                final currentUser = FirebaseAuth.instance.currentUser;
                final userId = currentUser?.uid;
                
                if (selectedBloodType == null || selectedBloodType!.isEmpty) {
                  ShowSnackBar.ShowSnackBarErrMessage(
                    context, 
                    "Please select blood type"
                  );
                  return;
                }
                
                if (_addressController.text.isEmpty) {
                  ShowSnackBar.ShowSnackBarErrMessage(
                    context, 
                    "Please enter location"
                  );
                  return;
                }

                BlocProvider.of<EmergencyCubit>(context).addEmergency(
                  EmergencyModel(
                    userId: userId!,
                    bloodType: selectedBloodType!,
                    details: _notesController.text,
                    address: _addressController.text,
                    time: Timestamp.now(),
                  ),
                );
                
                ShowSnackBar.ShowSnackBarMessage(
                  context, 
                  "Emergency request sent successfully!"
                );
                
                GoRouter.of(context).pop();
              },
              icon: const Icon(
                Icons.error_outline,
                color: AppColors.background,
              ),
              label: const Text(
                "Send Emergency Alert",
                style: AppStyles.styleBold16,
              ),

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffc22222),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}