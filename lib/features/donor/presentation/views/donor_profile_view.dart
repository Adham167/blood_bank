import 'dart:developer';

import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:blood_bank/features/donor/presentation/manager/donor_cubit/donor_cubit.dart';
import 'package:blood_bank/features/donor/presentation/widgets/contact_buttons.dart';
import 'package:blood_bank/features/donor/presentation/widgets/donation_history.dart';
import 'package:blood_bank/features/donor/presentation/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // لإضافة تنسيق التاريخ

class DonorProfileView extends StatelessWidget {
  const DonorProfileView({super.key, required this.doner});
  final UserModel doner;

  @override
  Widget build(BuildContext context) {
    log("Doner prifile view  ${doner.uid}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DonorCubit>().getDonationHistoryForUser(doner.uid);
    });

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
      body: BlocListener<DonorCubit, DonorState>(
        listener: (context, state) {
          if (state is DonorDonationLoaded) {}
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ProfileCard(doner: doner),
              const SizedBox(height: 20),
              ContactButtons(donerModel: doner),
              const SizedBox(height: 20),

              BlocBuilder<DonorCubit, DonorState>(
                builder: (context, state) {
                  if (state is DonorLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DonorFailure) {
                    return Text('Error: ${state.errMessage}');
                  } else if (state is DonorDonationLoaded) {
                    final donations = state.donations;

                    // التحقق مما إذا كانت هناك تبرعات
                    if (donations.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Available for donation",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 12),
                          DonationHistory(donationHistory: donations),
                        ],
                      );
                    }

                    final lastDonationDate = donations.first.time;

                    final differenceInDays =
                        DateTime.now().difference(lastDonationDate).inDays;
                    final available = differenceInDays >= 56;

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
                        if (!available) ...[
                          const SizedBox(height: 8),
                          Text(
                            "Last donation: ${DateFormat('dd/MM/yyyy').format(lastDonationDate)}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text(
                            "Can donate again after: ${DateFormat('dd/MM/yyyy').format(lastDonationDate.add(const Duration(days: 56)))}",
                            style: const TextStyle(color: Colors.orange),
                          ),
                        ],
                        const SizedBox(height: 12),

                        DonationHistory(donationHistory: donations),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
