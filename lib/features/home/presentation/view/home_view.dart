import 'package:blood_bank/core/app/app_router.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/features/donor/presentation/manager/donor_cubit/donor_cubit.dart';
import 'package:blood_bank/features/emergency/presentation/manager/emergency_cubit/emergency_cubit.dart';
import 'package:blood_bank/features/donor/presentation/widgets/donars_list_view.dart';
import 'package:blood_bank/features/emergency/presentation/manager/emergency_cubit/emergency_state.dart';
import 'package:blood_bank/features/home/presentation/view/widgets/Doner_list_is_empty.dart';
import 'package:blood_bank/features/home/presentation/view/widgets/custom_circular_progress.dart';
import 'package:blood_bank/features/home/presentation/view/widgets/donors_error_widget.dart';
import 'package:blood_bank/features/home/presentation/view/widgets/emergency_error.dart';
import 'package:blood_bank/features/home/presentation/view/widgets/no_emergency.dart';
import 'package:blood_bank/features/home/presentation/view/widgets/show_more_doners_button.dart';
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

              BlocBuilder<EmergencyCubit, EmergencyState>(
                builder: (context, state) {
                  if (state is EmergencyLoading) {
                    return CustomCircularProgress();
                  } else if (state is EmergencySuccess) {
                    return Column(
                      children: [
                        NoteEmergencyBody(emergencyModel: state.emergencyModel),
                        const SizedBox(height: 8),
                      ],
                    );
                  } else if (state is EmergencyEmpty) {
                    return NoEmergency();
                  } else if (state is EmergencyFailure) {
                    return EmergencyError(errMessage: state.errMessage);
                  }
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<EmergencyCubit>().getLatestEmergency();
                  });
                  return CustomCircularProgress();
                },
              ),

              GridViewBody(),
              const SizedBox(height: 24),

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

              BlocBuilder<DonorCubit, DonorState>(
                builder: (context, state) {
                  if (state is DonorInitial) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.read<DonorCubit>().getDonors();
                    });
                  }

                  if (state is DonorLoading) {
                    return CustomCircularProgress();
                  } else if (state is DonorFailure) {
                    return DonorsErrorWidget(errMessage: state.errMessage);
                  } else if (state is DonorSuccess) {
                    return _buildDonorsList(state, context);
                  } else if (state is DonorDonationLoaded) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.read<DonorCubit>().getDonors();
                    });
                    return CustomCircularProgress();
                  }

                  return CustomCircularProgress();
                },
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDonorsList(DonorSuccess state, BuildContext context) {
    final donors = state.doners ?? [];
    if (donors.isEmpty) {
      return DonerListIsEmpty();
    }
    final limitedDonors = donors.take(3).toList();
    return Column(
      children: [
        DonarsListView(doners: limitedDonors),
        if (donors.length > 3) ShowMoreDonersButton(donors: donors),
      ],
    );
  }
}
