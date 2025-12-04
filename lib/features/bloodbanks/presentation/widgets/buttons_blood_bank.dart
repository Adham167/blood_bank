import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/features/donor/data/donation_model.dart';
import 'package:blood_bank/features/donor/presentation/manager/donor_cubit/donor_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonsBloodBank extends StatelessWidget {
  const ButtonsBloodBank({super.key, required this.bloodBankName});

  final String bloodBankName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 📞 Call Button
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: Colors.grey[400]!),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                // TODO: Implement call functionality
              },
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.call, size: 18, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Text(
                      "Call",
                      style: AppStyles.styleBold15.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // 🗺️ Directions Button
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primary,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                // TODO: Implement directions functionality
                // يمكنك استخدام: url_launcher لفتح Google Maps
              },
              child: Center(
                child: Text(
                  "Directions",
                  style: AppStyles.styleBold15.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // ✅ Confirm Donation Button
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.green,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () async {
                await _handleConfirmDonation(context);
              },
              child: Center(
                child: Text(
                  "Confirm",
                  style: AppStyles.styleBold15.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleConfirmDonation(BuildContext context) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      _showMessage(context, "Please login first");
      return;
    }

    // إظهار تأكيد
    final confirmed = await _showConfirmationDialog(context);
    if (!confirmed) return;

    // إنشاء DonationModel جديد
    final newDonation = DonationModel(
      time: DateTime.now(),
      address: bloodBankName, // اسم البنك كعنوان للتبرع
      donationType: "Blood Bank Donation",
      // يمكنك إضافة المزيد من البيانات
      // location: bloodBankAddress,
      // bloodBankId: bloodBankId,
    );

    try {
      // إضافة التبرع للمستخدم الحالي
      await BlocProvider.of<DonorCubit>(
        context,
      ).addDonationToUser(uid: currentUser.uid, donation: newDonation);

      _showSuccessMessage(context);
    } catch (e) {
      _showErrorMessage(context, e.toString());
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    bool confirmed = false;

    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.bloodtype_outlined, color: Colors.red),
                SizedBox(width: 12),
                Text("Confirm Donation"),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Did you donate at $bloodBankName?"),
                const SizedBox(height: 8),
                const Text(
                  "This will add a donation record to your history.",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  confirmed = true;
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Confirm"),
              ),
            ],
          ),
    );

    return confirmed;
  }

  void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Donation recorded at $bloodBankName",
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showErrorMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Error: ${error.length > 50 ? '${error.substring(0, 50)}...' : error}",
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
