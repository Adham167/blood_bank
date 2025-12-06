import 'package:blood_bank/features/donor/presentation/manager/donor_cubit/donor_cubit.dart';
import 'package:blood_bank/features/donor/presentation/widgets/custom_not_found.dart';
import 'package:blood_bank/features/donor/presentation/widgets/donars_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBlocBuilderWidget extends StatelessWidget {
  const SearchBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonorCubit, DonorState>(
      builder: (context, state) {
        if (state is DonorFailure) {
          return Center(child: Text(state.errMessage));
        } else if (state is DonorLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DonorSuccess) {
          if (state.doners.isEmpty) {
            return CustomNotFound();
          }
          return DonarsListView(doners: state.doners);
        }

        return const SizedBox();
      },
    );
  }
}
