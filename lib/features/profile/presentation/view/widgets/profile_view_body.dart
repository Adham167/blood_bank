import 'dart:developer';

import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/features/donor/presentation/manager/donor_cubit/donor_cubit.dart';
import 'package:blood_bank/features/profile/presentation/view/widgets/donataion_history_is_empty.dart';
import 'package:blood_bank/features/profile/presentation/view/widgets/donation_error_handling.dart';
import 'package:blood_bank/features/profile/presentation/view/widgets/donation_statistics.dart';
import 'package:blood_bank/features/profile/presentation/view/widgets/profile_info_card.dart';
import 'package:blood_bank/presentation/widgets/edit_profile_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  String name = '';
  String email = '';
  String phone = '';
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    loadUserData();
    _getCurrentUserId();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('user_name') ?? '';
      email = prefs.getString('user_email') ?? '';
      phone = prefs.getString('user_phone') ?? '';
    });
  }

  void _getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserId = user.uid;
      });
      log(" prifile view  ${user.uid}");

      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<DonorCubit>().getDonationHistoryForUser(user.uid);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Information Section",
              style: AppStyles.styleBold24.copyWith(color: AppColors.secondary),
            ),
            const SizedBox(height: 8),
            ProfileInfoCard(name: name, email: email, phone: phone),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Donation History",
                  style: AppStyles.styleBold24.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
                if (currentUserId != null)
                  IconButton(
                    onPressed: () {
                      context.read<DonorCubit>().getDonationHistoryForUser(
                        currentUserId!,
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    tooltip: "Refresh donations",
                  ),
              ],
            ),
            const SizedBox(height: 12),

            BlocBuilder<DonorCubit, DonorState>(
              builder: (context, state) {
                if (state is DonorDonationLoaded) {
                  final donations = state.donations;

                  if (donations.isEmpty) return DonataionHistoryIsEmpty();

                  final totalDonations = donations.length;
                  final lastDonation = donations.first.time;
                  final nextDonationDate = lastDonation.add(
                    const Duration(days: 56),
                  );

                  return DonationStatistics(
                    totalDonations: totalDonations,
                    nextDonationDate: nextDonationDate,
                    donations: donations,
                  );
                } else if (state is DonorFailure) {
                  return DonationErrorHandling(
                    currentUserId: currentUserId,
                    errMessage: state.errMessage,
                  );
                }

                // لو لسه مفيش بيانات تبين Progress
                return const Center(child: CircularProgressIndicator());
              },
            ),

            const SizedBox(height: 24),

            const EditProfileSection(),
          ],
        ),
      ),
    );
  }
}
