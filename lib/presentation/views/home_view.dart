import 'package:blood_bank/core/app/app_router.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/presentation/widgets/donars_list_view.dart';
import 'package:blood_bank/presentation/widgets/grid_view_body.dart';
import 'package:blood_bank/features/emergency/presentation/widgets/note_emergency_body.dart';
import 'package:blood_bank/presentation/widgets/top_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopBody(),
            SizedBox(height: 28),
            NoteEmergencyBody(),
            SizedBox(height: 8),
            GridViewBody(),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    "Nearby Donors",
                    style: AppStyles.styleBold18.copyWith(color: Colors.black),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed:
                        () => GoRouter.of(context).push(AppRouter.kDonerView),
                    child: Text("View All", style: AppStyles.styleSemiBold12),
                  ),
                ],
              ),
            ),
            DonarsListView(),
            SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
