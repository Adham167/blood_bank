import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/core/utils/custom_text.dart';
import 'package:blood_bank/features/donor/presentation/manager/donor_cubit/donor_cubit.dart';
import 'package:blood_bank/features/donor/presentation/widgets/donation_history.dart';
import 'package:blood_bank/presentation/widgets/edit_profile_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
      // جلب تاريخ التبرعات للمستخدم الحالي
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<DonorCubit>().getDonationHistoryForUser(user.uid);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffafafa),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 📋 Information Section
              Text(
                "Information Section",
                style: AppStyles.styleBold24.copyWith(
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xfffafafa),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.secondbackground,
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.primary.withOpacity(0.1),
                            child: Icon(Icons.person, color: AppColors.primary),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  email,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomText(text1: "Name: ", text2: name),
                      CustomText(text1: "Phone: ", text2: phone),
                      CustomText(text1: "Email: ", text2: email),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 🩸 My Donation History
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
                  if (state is DonorLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is DonorFailure) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 40,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Error loading donations",
                            style: TextStyle(
                              color: Colors.red[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            state.errMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red[600]),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              if (currentUserId != null) {
                                context
                                    .read<DonorCubit>()
                                    .getDonationHistoryForUser(currentUserId!);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                            child: const Text("Try Again"),
                          ),
                        ],
                      ),
                    );
                  } else if (state is DonorDonationLoaded) {
                    final donations = state.donations;

                    if (donations.isEmpty) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.water_drop_outlined,
                              color: Colors.grey[400],
                              size: 60,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "No Donations Yet",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Start your journey of saving lives!",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                // يمكنك إضافة navigation إلى صفحة التبرع
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                              ),
                              child: const Text("Find Donation Centers"),
                            ),
                          ],
                        ),
                      );
                    }

                    // ✅ إحصائيات التبرعات
                    final totalDonations = donations.length;
                    final lastDonation =
                        donations.isNotEmpty
                            ? donations.first.time
                            : DateTime.now();
                    final nextDonationDate = lastDonation.add(
                      const Duration(days: 56),
                    );

                    return Column(
                      children: [
                        // 📊 Donation Statistics
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "$totalDonations",
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Text(
                                    "Total Donations",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 40,
                                width: 1,
                                color: Colors.grey[300],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: AppColors.primary,
                                    size: 24,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Next: ${nextDonationDate.day}/${nextDonationDate.month}",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 🗂️ Donation History List
                        DonationHistory(donationHistory: donations),
                      ],
                    );
                  } else {
                    // حالة initial أو loading
                    return Container(
                      padding: const EdgeInsets.all(20),
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
              const SizedBox(height: 24),

              // ⚙️ Edit Profile Section
              const EditProfileSection(),
            ],
          ),
        ),
      ),
    );
  }
}
