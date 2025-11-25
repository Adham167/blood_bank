import 'package:blood_bank/features/auth/presentation/views/login_view.dart';
import 'package:blood_bank/features/auth/presentation/views/signup_view.dart';
import 'package:blood_bank/presentation/views/home_view.dart';
import 'package:blood_bank/presentation/views/onboarding_view.dart';
import 'package:blood_bank/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static String kLoginView = "/LoginView";
  static String kSignUpView = "/SignUpView";
  static String kHomeView = "/HomeView";
  static String kOnboardingView = "/OnboardingView";

  static final router = GoRouter(
    routes: [
      GoRoute(path: "/", builder: (context, state) => SplashView()),
      GoRoute(path: kLoginView, builder: (context, state) => LoginView()),
      GoRoute(path: kSignUpView, builder: (context, state) => SignUpView()),
      GoRoute(path: kHomeView, builder: (context, state) => HomeView()),
        GoRoute(
      path: kOnboardingView,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: OnboardingView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 200),
        );
      },
    ),
    ],
  );
}
