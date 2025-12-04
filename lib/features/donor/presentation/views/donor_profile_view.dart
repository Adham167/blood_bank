import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:blood_bank/features/donor/presentation/manager/donor_cubit/donor_cubit.dart';
import 'package:blood_bank/features/donor/presentation/widgets/contact_buttons.dart';
import 'package:blood_bank/features/donor/presentation/widgets/donation_history.dart';
import 'package:blood_bank/features/donor/presentation/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonorProfileView extends StatelessWidget {
  const DonorProfileView({super.key, required this.doner});
  final UserModel doner;

  @override
  Widget build(BuildContext context) {
    // أول ما الصفحة تتحمل، نجلب الـ donations الخاصة باليوزر
    // context.read<DonorCubit>().getDonationHistoryForUser(doner.uid);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xfffafafa),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Donor Profile",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileCard(doner: doner),
            const SizedBox(height: 20),
            ContactButtons(donerModel: doner),
            const SizedBox(height: 20),

            // BlocBuilder لعرض الدونيشن هيستوري وحالة التبرع
            BlocBuilder<DonorCubit, DonorState>(
              builder: (context, state) {
                if (state is DonorLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DonorFailure) {
                  return Text('Error: ${state.errMessage}');
                } else if (state is DonorDonationLoaded) {
                  final donations = state.donations;

                  final lastDonationDate =
                      donations.isNotEmpty ? donations.last.time : null;

                  final available =
                      lastDonationDate == null
                          ? true
                          : DateTime.now()
                                  .difference(lastDonationDate)
                                  .inHours >=
                              2;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        available
                            ? "Available for donation"
                            : "Not available yet",
                        style: TextStyle(
                          color: available ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 12),

                      DonationHistory(donationHistory: donations),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
