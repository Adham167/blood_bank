import 'package:blood_bank/features/donor/presentation/widgets/contact_buttons.dart';
import 'package:blood_bank/features/donor/presentation/widgets/donation_history.dart';
import 'package:blood_bank/features/donor/presentation/widgets/profile_card.dart';
import 'package:flutter/material.dart';

class DonorProfileView extends StatelessWidget {
  const DonorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileCard(name: "Sarah johnson"),
            SizedBox(height: 20),
            ContactButtons(),
            SizedBox(height: 20),
            DonationHistory(),
          ],
        ),
      ),
    );
  }
}
