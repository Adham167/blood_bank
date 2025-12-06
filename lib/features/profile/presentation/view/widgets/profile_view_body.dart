import 'dart:developer';

import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/features/donor/presentation/manager/donor_cubit/donor_cubit.dart';
import 'package:blood_bank/features/profile/presentation/view/widgets/donation_history_widget.dart';
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
  String _name = '';
  String _email = '';
  String _phone = '';
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _initializeCurrentUser();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('user_name') ?? '';
      _email = prefs.getString('user_email') ?? '';
      _phone = prefs.getString('user_phone') ?? '';
    });
  }

  void _initializeCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() {
      _currentUserId = user.uid;
    });

    log("ProfileView currentUserId: ${user.uid}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DonorCubit>().getDonationHistoryForUser(user.uid);
    });
  }

  void _refreshDonations() {
    if (_currentUserId != null) {
      context.read<DonorCubit>().getDonationHistoryForUser(_currentUserId!);
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
            _buildSectionTitle("Information Section"),
            const SizedBox(height: 8),
            ProfileInfoCard(name: _name, email: _email, phone: _phone),
            const SizedBox(height: 24),

            _buildDonationHistoryHeader(),

            const SizedBox(height: 12),
            DonationHistoryWidget(currentUserId: _currentUserId??""),
            const SizedBox(height: 24),

            const EditProfileSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppStyles.styleBold24.copyWith(color: AppColors.secondary),
    );
  }

  Widget _buildDonationHistoryHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSectionTitle("My Donation History"),
        if (_currentUserId != null)
          IconButton(
            onPressed: _refreshDonations,
            icon: const Icon(Icons.refresh),
            tooltip: "Refresh donations",
          ),
      ],
    );
  }


}
