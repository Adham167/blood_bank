import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:blood_bank/features/donor/data/donation_model.dart';
import 'package:blood_bank/features/donor/presentation/manager/donor_cubit/donor_cubit.dart';
import 'package:blood_bank/features/donor/presentation/widgets/custom_donor_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ContactButtons extends StatelessWidget {
  const ContactButtons({super.key, required this.donerModel});
  final UserModel donerModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomDonorButton(
                color: AppColors.primary,
                text: "Call",
                icon: Icons.call,
                isFilled: true,
                onTap: () {
                  //customLaunchUrl(context, 'tel:${donerModel.phone}');
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomDonorButton(
                text: "Message",
                icon: Icons.message,
                onTap: () {
                  //  customLaunchUrl(context, 'sms:${donerModel.phone}?body=Hello');
                },
                isFilled: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        CustomDonorButton(
          color: Colors.green,
          icon: Icons.verified,
          text: "Confirm",
          isFilled: true,
          onTap: () async {
            final cubit = BlocProvider.of<DonorCubit>(context);
            final currentState = cubit.state;

            if (currentState is DonorDonationLoaded) {
              final donations = currentState.donations;

              if (donations.isNotEmpty) {
                final lastDonationDate = donations.first.time;
                final differenceInDays =
                    DateTime.now().difference(lastDonationDate).inDays;

                if (differenceInDays < 56) {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: const Text("Not Available"),
                          content: Text(
                            "This donor can donate again after "
                            "${DateFormat('dd/MM/yyyy').format(lastDonationDate.add(const Duration(days: 56)))}",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                  );
                  return;
                }
              }
            }

            final newDonation = DonationModel(
              time: DateTime.now(),
              address: donerModel.address,
              donationType: donerModel.bloodType,
            );

            await cubit.addDonationToUser(
              uid: donerModel.uid,
              donation: newDonation,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Donation recorded successfully!"),
                backgroundColor: Colors.green,
              ),
            );
            GoRouter.of(context).pop();
          },
        ),
      ],
    );
  }
}
