import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:blood_bank/features/auth/presentation/views/login_view.dart';
import 'package:blood_bank/features/auth/presentation/views/signup_view.dart';
import 'package:blood_bank/features/bloodbanks/presentation/views/blood_bank_view.dart';
import 'package:blood_bank/features/donor/data/doner_model.dart';
import 'package:blood_bank/features/donor/presentation/manager/donor_cubit/donor_cubit.dart';
import 'package:blood_bank/features/donor/presentation/views/doner_view.dart';
import 'package:blood_bank/features/donor/presentation/views/donor_profile_view.dart';
import 'package:blood_bank/features/emergency/presentation/manager/emergency_cubit/emergency_cubit.dart';
import 'package:blood_bank/features/emergency/presentation/views/emergency_view.dart';
import 'package:blood_bank/presentation/views/home_view.dart';
import 'package:blood_bank/presentation/views/map_view.dart';
import 'package:blood_bank/presentation/views/onboarding_view.dart';
import 'package:blood_bank/presentation/views/profile_view.dart';
import 'package:blood_bank/presentation/views/splash_view.dart';
import 'package:blood_bank/presentation/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static String kLoginView = "/LoginView";
  static String kSignUpView = "/SignUpView";
  static String kHomeView = "/HomeView";
  static String kOnboardingView = "/OnboardingView";
  static String kDonerView = "/DonerView";
  static String kBloodBankView = "/BloodBankView";
  static String kMapView = "/MapView";
  static String kEmergencyView = "/EmergencyView";
  static String kProfileView = "/ProfileView";
  static String kDonorProfileView = "/DonorProfileView";
  static String kCustomNavigationBar = "/CustomNavigationBar";

  static final router = GoRouter(
    routes: [
      GoRoute(path: "/", builder: (context, state) => SplashView()),
      GoRoute(path: kLoginView, builder: (context, state) => LoginView()),
      GoRoute(path: kSignUpView, builder: (context, state) => SignUpView()),
      GoRoute(
        path: kHomeView,
        builder:
            (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => DonorCubit()..getDonors()),
                BlocProvider(
                  create: (context) => EmergencyCubit()..getLatestEmergency(),
                ),
              ],
              child: HomeView(),
            ),
      ),
      GoRoute(
        path: kDonerView,
        builder: (context, state) {
          final data =
              state.extra != null ? state.extra as Map<String, dynamic> : {};

          return BlocProvider(
            create: (context) => DonorCubit()..getDonors(),
            child: DonerView(
              initialBloodType: data['type'] ?? "",
              initialLocation: data['location'] ?? "",
            ),
          );
        },
      ),
      GoRoute(
        path: kCustomNavigationBar,
        builder:
            (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => DonorCubit()..getDonors()),
                BlocProvider(
                  create: (context) => EmergencyCubit()..getLatestEmergency(),
                ),
              ],
              child: CustomNavigationBar(),
            ),
      ),
      GoRoute(
        path: kBloodBankView,
        builder:
            (context, state) => BlocProvider(
              create: (context) => DonorCubit(),
              child: BloodBankView(),
            ),
      ),
      GoRoute(path: kMapView, builder: (context, state) => MapView()),
      GoRoute(
        path: kEmergencyView,
        builder: (context, state) => EmergencyView(),
      ),
      GoRoute(path: kProfileView, builder: (context, state) => ProfileView()),
      GoRoute(
        path: kDonorProfileView,

        builder: (context, state) {
          final donor = state.extra as UserModel;
          return BlocProvider(
            create:
                (context) => DonorCubit()..getDonationHistoryForUser(donor.uid),
            child: DonorProfileView(doner: donor),
          );
        },
      ),
      GoRoute(
        path: kOnboardingView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: OnboardingView(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: Duration(milliseconds: 200),
          );
        },
      ),
    ],
  );
}
