import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/core/utils/custom_dropdown_button.dart';
import 'package:blood_bank/features/emergency/presentation/widgets/blood_request_form.dart';
import 'package:blood_bank/features/emergency/presentation/widgets/emergency_alert.dart';
import 'package:blood_bank/features/emergency/presentation/widgets/next_steps.dart';
import 'package:flutter/material.dart';

class EmergencyView extends StatelessWidget {
  const EmergencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xfffafafa),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Emergency Request",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const EmergencyAlert(),
            const SizedBox(height: 16),
            BloodRequestForm(),
            const SizedBox(height: 16),
            const NextSteps(),
          ],
        ),
      ),
    );
  }
}

