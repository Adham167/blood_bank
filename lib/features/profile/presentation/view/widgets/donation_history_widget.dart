import 'package:blood_bank/features/profile/presentation/view/widgets/donation_error_handling.dart';
import 'package:blood_bank/features/profile/presentation/view/widgets/donation_statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../donor/presentation/manager/donor_cubit/donor_cubit.dart' show DonorDonationLoaded, DonorCubit, DonorState, DonorFailure;
import 'donataion_history_is_empty.dart' show DonataionHistoryIsEmpty;
class  DonationHistoryWidget extends StatelessWidget {
  const DonationHistoryWidget({super.key, required this.currentUserId});
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonorCubit, DonorState>(
      builder: (context, state) {
        if (state is DonorDonationLoaded) {
          final donations = state.donations;
          if (donations.isEmpty) return const DonataionHistoryIsEmpty();

          final totalDonations = donations.length;
          final lastDonation = donations.first.time;
          final nextDonationDate = lastDonation.add(const Duration(days: 56));

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

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

