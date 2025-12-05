import 'package:blood_bank/core/utils/widgets/custom_app_bar.dart';
import 'package:blood_bank/features/donor/presentation/manager/donor_cubit/donor_cubit.dart';
import 'package:blood_bank/features/profile/presentation/view/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DonorCubit(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Profile'),
        body: ProfileViewBody(),
      ),
    );
  }
}
