import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_router.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/core/constants/show_snack_bar.dart';
import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:blood_bank/features/emergency/data/models/emergency_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoteEmergencyBody extends StatelessWidget {
  const NoteEmergencyBody({super.key, required this.emergencyModel});
  final EmergencyModel emergencyModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.primary,
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.error_outline, color: AppColors.background),
                  const SizedBox(width: 8),
                  Text(
                    "URGENT: ${emergencyModel.bloodType} Needed",
                    style: AppStyles.styleBold20.copyWith(
                      color: AppColors.background,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: AppColors.background,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    emergencyModel.address,
                    style: AppStyles.styleMedium14.copyWith(
                      color: AppColors.background,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              GestureDetector(
                onTap: () async {
                  await _handleDonateNow(context);
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      "Donate Now",
                      style: AppStyles.styleMedium16.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleDonateNow(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // 🔥 البحث في كل المستندات عن الـ uid المناسب
      final allUsersSnapshot =
          await FirebaseFirestore.instance.collection('Users').get();

      UserModel? foundUser;

      for (var doc in allUsersSnapshot.docs) {
        final data = doc.data();
        if (data['uid'] == emergencyModel.userId) {
          foundUser = UserModel.fromJson(data);
          break;
        }
      }

      Navigator.of(context).pop();

      if (foundUser == null) {
        ShowSnackBar.ShowSnackBarErrMessage(
          context,
          "Requester not found. ID: ${emergencyModel.userId}",
        );
        return;
      }

      GoRouter.of(context).push(AppRouter.kDonorProfileView, extra: foundUser);
    } catch (e) {
      Navigator.of(context).pop();
      ShowSnackBar.ShowSnackBarErrMessage(context, "Error: ${e.toString()}");
    }
  }
}
