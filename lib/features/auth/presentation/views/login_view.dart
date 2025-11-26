import 'package:blood_bank/core/app/app_router.dart';
import 'package:blood_bank/core/constants/show_snack_bar.dart';
import 'package:blood_bank/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:blood_bank/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late Animation<double> _fade;
  late AnimationController _buttonCtrl;

  @override
  void initState() {
    super.initState();

    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fade = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();

    _buttonCtrl = AnimationController(
      vsync: this,
      lowerBound: 0.9,
      upperBound: 1.0,
      duration: const Duration(milliseconds: 140),
      value: 1,
    );
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _buttonCtrl.dispose();
    super.dispose();
  }

  bool isLoading = false;
  String? email;
  String? password;
  bool _obscure = true;
  GlobalKey<FormState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            isLoading = true;
          } else if (state is LoginSuccess) {
            ShowSnackBar.ShowSnackBarMessage(context, "Logging in Success");
            GoRouter.of(
              context,
            ).pushReplacement(AppRouter.kCustomNavigationBar);
          } else if (state is LoginFailure) {
            isLoading = false;
            ShowSnackBar.ShowSnackBarErrMessage(context, state.errMessage);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Scaffold(
              backgroundColor: const Color(0xffFAFAFA),
              body: SafeArea(
                child: FadeTransition(
                  opacity: _fade,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Form(
                      key: globalKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          const SizedBox(height: 50),

                          const Text(
                            "Welcome Back 🩸",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Sign in to continue",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 45),

                          CustomTextFormField(
                            label: "Emial",
                            icon: Icon(Icons.email),
                            isEmailField: true,
                            onChanged: (data) => email = data,
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            label: "Password",
                            icon: Icon(Icons.lock),
                            obscureText: _obscure,
                            iconButton: IconButton(
                              onPressed:
                                  () => setState(() {
                                    _obscure = !_obscure;
                                  }),
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            onChanged: (data) => password = data,
                          ),
                          const SizedBox(height: 35),

                          ScaleTransition(
                            scale: _buttonCtrl,
                            child: SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await _buttonCtrl.reverse();
                                  await _buttonCtrl.forward();
                                  if (globalKey.currentState!.validate()) {
                                    BlocProvider.of<LoginCubit>(
                                      context,
                                    ).login(email: email!, password: password!);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffD32F2F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 3,
                                ),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account? "),
                              GestureDetector(
                                onTap: () {
                                  GoRouter.of(
                                    context,
                                  ).push(AppRouter.kSignUpView);
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Color(0xffD32F2F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
