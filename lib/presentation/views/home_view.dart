import 'package:blood_bank/core/app/app_router.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/features/donor/presentation/manager/donor_cubit/donor_cubit.dart';
import 'package:blood_bank/features/emergency/presentation/manager/emergency_cubit/emergency_cubit.dart';
import 'package:blood_bank/features/donor/presentation/widgets/donars_list_view.dart';
import 'package:blood_bank/features/emergency/presentation/manager/emergency_cubit/emergency_state.dart';
import 'package:blood_bank/presentation/widgets/grid_view_body.dart';
import 'package:blood_bank/features/emergency/presentation/widgets/note_emergency_body.dart';
import 'package:blood_bank/presentation/widgets/top_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.primary,
      //   onPressed: () {
      //     showAddProductDialog(context);
      //   },
      //   child: Icon(Icons.add, color: AppColors.secondary),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopBody(),
            SizedBox(height: 28),
            // في صفحة الهوم
            BlocBuilder<EmergencyCubit, EmergencyState>(
              builder: (context, state) {
                if (state is EmergencyLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is EmergencySuccess) {
                  return NoteEmergencyBody(
                    emergencyModel: state.emergencyModel,
                  );
                } else if (state is EmergencyEmpty) {
                  return _buildNoEmergencies();
                } else if (state is EmergencyFailure) {
                  return Text('Error: ${state.errMessage}');
                }
                return const SizedBox();
              },
            ),

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
            BlocBuilder<DonorCubit, DonorState>(
              builder: (context, state) {
                if (state is DonorLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DonorFailure) {
                  return Center(child: Text(state.errMessage));
                } else if (state is DonorSuccess) {
                  return DonarsListView(doners: state.doners ?? []);
                }
                return const SizedBox();
              },
            ),
            SizedBox(height: 64),
          ],
        ),
      ),
    );
  }

  Widget _buildNoEmergencies() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[100],
        ),
        child: Column(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green, size: 48),
            SizedBox(height: 12),
            Text(
              "No Active Emergencies",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "All blood needs are currently met",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
