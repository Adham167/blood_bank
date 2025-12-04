import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:blood_bank/features/donor/data/donation_model.dart';
import 'package:blood_bank/features/donor/presentation/manager/donor_cubit/donor_cubit.dart';
import 'package:blood_bank/features/donor/presentation/widgets/custom_donor_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomDonorButton(
                text: "Message",
                icon: Icons.message,
                onTap: () {},
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
          onTap: () {
            final newDonation = DonationModel(
              time: DateTime.now(), // وقت الدونايشن الحالي
              address:
                  donerModel.address, // ممكن تاخدها من input أو أي مكان مناسب
              donationType: donerModel.bloodType, // النوع اللي انت عايزه
            );

            BlocProvider.of<DonorCubit>(
              context,
            ).addDonationToUser(uid: donerModel.uid, donation: newDonation);
          },
        ),
      ],
    );
  }
}
