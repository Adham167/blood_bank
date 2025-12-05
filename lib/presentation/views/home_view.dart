import 'package:blood_bank/core/app/app_colors.dart';
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
    return BlocProvider(
      create: (context) => DonorCubit()..getDonors(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              TopBody(),
              const SizedBox(height: 28),

              // 🚨 Emergency Section
              BlocBuilder<EmergencyCubit, EmergencyState>(
                builder: (context, state) {
                  if (state is EmergencyLoading) {
                    return _buildEmergencyLoading();
                  } else if (state is EmergencySuccess) {
                    return Column(
                      children: [
                        NoteEmergencyBody(emergencyModel: state.emergencyModel),
                        const SizedBox(height: 8),
                      ],
                    );
                  } else if (state is EmergencyEmpty) {
                    return _buildNoEmergencies();
                  } else if (state is EmergencyFailure) {
                    return _buildEmergencyError(state);
                  }
                  // حالة Initial - نستدعي جلب البيانات
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<EmergencyCubit>().getLatestEmergency();
                  });
                  return _buildEmergencyLoading();
                },
              ),

              // 🏥 Services Grid
              GridViewBody(),
              const SizedBox(height: 24),

              // 👥 Nearby Donors Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      "Nearby Donors",
                      style: AppStyles.styleBold18.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed:
                          () => GoRouter.of(context).push(AppRouter.kDonerView),
                      child: Text("View All", style: AppStyles.styleSemiBold12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // 🔄 Nearby Donors List
              BlocBuilder<DonorCubit, DonorState>(
                builder: (context, state) {
                  // استدعاء البيانات أول مرة فقط
                  if (state is DonorInitial) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.read<DonorCubit>().getDonors();
                    });
                  }

                  if (state is DonorLoading) {
                    return _buildDonorsLoading();
                  } else if (state is DonorFailure) {
                    return _buildDonorsError(context, state);
                  } else if (state is DonorSuccess) {
                    return _buildDonorsList(state);
                  } else if (state is DonorDonationLoaded) {
                    // إذا كان في حالة DonorDonationLoaded، نرجع للـ DonorSuccess
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.read<DonorCubit>().getDonors();
                    });
                    return _buildDonorsLoading();
                  }

                  // أي حالة أخرى
                  return _buildDonorsLoading();
                },
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // 🚨 Emergency Loading
  Widget _buildEmergencyLoading() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  // 🚨 Emergency Error
  Widget _buildEmergencyError(EmergencyFailure state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red[700]),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Error: ${state.errMessage}',
                style: TextStyle(color: Colors.red[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 👥 Donors Loading
  Widget _buildDonorsLoading() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  // 👥 Donors Error
  Widget _buildDonorsError(BuildContext context, DonorFailure state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange),
        ),
        child: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange[700]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Unable to load donors",
                    style: TextStyle(
                      color: Colors.orange[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    state.errMessage.length > 60
                        ? "${state.errMessage.substring(0, 60)}..."
                        : state.errMessage,
                    style: TextStyle(color: Colors.orange[600], fontSize: 12),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => context.read<DonorCubit>().getDonors(),
              icon: Icon(Icons.refresh, color: Colors.orange[700]),
            ),
          ],
        ),
      ),
    );
  }

  // 👥 Donors List
  Widget _buildDonorsList(DonorSuccess state) {
    final donors = state.doners ?? [];

    if (donors.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            children: [
              Icon(Icons.people_outline, color: Colors.grey[400], size: 50),
              const SizedBox(height: 12),
              const Text(
                "No Donors Found",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                "Try adjusting your search criteria",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),
      );
    }

    // إظهار أول 3 متبرعين فقط في الهوم
    final limitedDonors = donors.take(3).toList();
    return Column(
      children: [
        DonarsListView(doners: limitedDonors),
        if (donors.length > 3)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "+ ${donors.length - 3} more donors available",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward, color: AppColors.primary, size: 16),
              ],
            ),
          ),
      ],
    );
  }

  // 🚨 No Emergencies
  Widget _buildNoEmergencies() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.green[50],
          border: Border.all(color: Colors.green),
        ),
        child: Column(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green[600],
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              "No Active Emergencies",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "All blood needs are currently met",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green[700]),
            ),
            const SizedBox(height: 12),
            Text(
              "Thank you for being a lifesaver! 🩸",
              style: TextStyle(
                color: Colors.green[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
