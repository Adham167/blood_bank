import 'package:blood_bank/core/app/app_router.dart';
import 'package:blood_bank/core/app/di/service_locator.dart';
import 'package:blood_bank/core/constants/show_snack_bar.dart';
import 'package:blood_bank/core/utils/widgets/custom_dropdown_button.dart';
import 'package:blood_bank/features/auth/domain/repos/auth_repo.dart';
import 'package:blood_bank/features/auth/presentation/manager/signup_cubit/signup_cubit.dart';
import 'package:blood_bank/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> with TickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late Animation<double> _fade;
  late AnimationController _buttonCtrl;

  bool _obscure = true;

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

  Future<void> saveUserData(String name, String email, String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
    await prefs.setString('user_phone', phone);
  }

  bool isLoading = false;
  late String name, phone, email, password, address, bloodType;
  GlobalKey<FormState> globalKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(getIt<AuthRepo>()),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            ShowSnackBar.ShowSnackBarMessage(
              context,
              "Creating Account Successfully",
            );
            saveUserData(name, email, phone);
            GoRouter.of(context).push(AppRouter.kLoginView);
          } else if (state is SignupFailure) {
            isLoading = false;
            ShowSnackBar.ShowSnackBarErrMessage(context, state.errMessage);
          } else if (state is SignupLoading) {
            isLoading = true;
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
                    child: SingleChildScrollView(
                      child: Form(
                        key: globalKey,
                        autovalidateMode: autovalidateMode,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 80),
                            const Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Join the community and help save lives',
                              style: TextStyle(color: Colors.black54),
                            ),
                            const SizedBox(height: 30),

                            CustomTextFormField(
                              label: "Full Name",
                              icon: Icon(Icons.person),
                              onChanged: (data) => name = data,
                            ),
                            const SizedBox(height: 16),

                            CustomTextFormField(
                              label: "Phone",
                              icon: Icon(Icons.phone),
                              onChanged: (data) => phone = data,
                            ),
                            const SizedBox(height: 16),
                            CustomTextFormField(
                              label: "Email",
                              icon: Icon(Icons.email),
                              isEmailField: true,
                              onChanged: (data) => email = data,
                            ),
                            const SizedBox(height: 16),
                            CustomTextFormField(
                              label: "address",
                              icon: Icon(Icons.directions),
                              onChanged: (data) => address = data,
                            ),
                            const SizedBox(height: 16),
                            CustomDropdownButton(
                              onChanged: (value) {
                                bloodType = value!;
                              },
                            ),
                            const SizedBox(height: 16),
                            CustomTextFormField(
                              label: "Password",
                              obscureText: _obscure,
                              icon: Icon(Icons.lock_outlined),
                              onChanged: (data) {
                                password = data;
                              },
                              iconButton: IconButton(
                                onPressed:
                                    () => setState(() => _obscure = !_obscure),
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),
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
                                      globalKey.currentState!.save();
                                      BlocProvider.of<SignupCubit>(
                                        context,
                                      ).signUp(
                                        email,
                                        password,
                                        name,
                                        phone,
                                        bloodType,
                                        address,
                                      );
                                    } else {
                                      setState(() {
                                        autovalidateMode =
                                            AutovalidateMode.always;
                                      });
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
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Already have an account? '),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: const Text(
                                    'Login',
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
            ),
          );
        },
      ),
    );
  }
}
