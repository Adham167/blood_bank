import 'package:blood_bank/features/auth/presentation/logic/login_logic.dart';
import 'package:blood_bank/features/auth/presentation/widgets/customElevatedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:blood_bank/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:blood_bank/core/constants/show_snack_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:blood_bank/core/app/app_router.dart';
import 'package:blood_bank/presentation/widgets/custom_text_form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with TickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late Animation<double> _fade;
  late AnimationController _buttonCtrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  bool _obscure = true;
  String email = '';
  String password = '';
  bool isLoading = false;

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginLoading) {
          setState(() => isLoading = true);
        } else if (state is LoginSuccess) {
          await LoginLogic.handleLoginSuccess(context, email);
          ShowSnackBar.ShowSnackBarMessage(context, "LoginSuccessfully");
          GoRouter.of(context).pushReplacement(AppRouter.kCustomNavigationBar);
          setState(() => isLoading = false);
        } else if (state is LoginFailure) {
          setState(() => isLoading = false);
          ShowSnackBar.ShowSnackBarErrMessage(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: FadeTransition(
            opacity: _fade,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 45),
                        CustomTextFormField(
                          label: "Email",
                          icon: const Icon(Icons.email),
                          isEmailField: true,
                          onChanged: (data) => email = data,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          label: "Password",
                          icon: const Icon(Icons.lock),
                          obscureText: _obscure,
                          iconButton: IconButton(
                            onPressed:
                                () => setState(() => _obscure = !_obscure),
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
                            child: CustomElevatedButton(
                              onpressed: () async {
                                await _buttonCtrl.reverse();
                                await _buttonCtrl.forward();
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  BlocProvider.of<LoginCubit>(
                                    context,
                                  ).login(email, password);
                                } else {
                                  setState(
                                    () =>
                                        _autovalidateMode =
                                            AutovalidateMode.always,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            GestureDetector(
                              onTap:
                                  () => GoRouter.of(
                                    context,
                                  ).push(AppRouter.kSignUpView),
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
