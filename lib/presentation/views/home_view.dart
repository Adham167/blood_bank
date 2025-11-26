import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_router.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/presentation/widgets/donars_list_view.dart';
import 'package:blood_bank/presentation/widgets/grid_view_body.dart';
import 'package:blood_bank/presentation/widgets/note_emergency_body.dart';
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
                  Text("View All", style: AppStyles.styleSemiBold12),
                ],
              ),
            ),
            DonarsListView(),
            SizedBox(height: 64),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => GoRouter.of(context).push(AppRouter.kHomeView),
                child: Column(
                  children: [
                    Icon(Icons.home,color: Colors.red),
                    SizedBox(height: 8),
                    Text(
                      "Home",
                      style: AppStyles.styleBold16.copyWith(
                        color: AppColors.secondbackground,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap:
                    () => GoRouter.of(context).push(AppRouter.kEmergencyView),
                child: Column(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red),
                    SizedBox(height: 6),
                    Text(
                      "ُEmergency",
                      style: AppStyles.styleBold16.copyWith(
                        color: AppColors.secondbackground,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => GoRouter.of(context).push(AppRouter.kProfileView),
                child: Column(
                  children: [
                    Icon(Icons.person, color: Colors.red),
                    SizedBox(height: 8),
                    Text(
                      "Profile",
                      style: AppStyles.styleBold16.copyWith(
                        color: AppColors.secondbackground,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
