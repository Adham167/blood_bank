import 'package:blood_bank/features/auth/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blood_bank/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:blood_bank/core/app/di/service_locator.dart';
import 'package:blood_bank/features/auth/domain/repos/auth_repo.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(getIt<AuthRepo>()),
      child: const Scaffold(
        body: SafeArea(
          child: LoginForm(),
        ),
      ),
    );
  }
}
