import 'package:blood_bank/core/app/app_router.dart';
import 'package:blood_bank/core/app/custom_bloc_observer.dart';
import 'package:blood_bank/core/app/di/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupGetIt();
  Bloc.observer = CustomBlocObserver();
  runApp(
    MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    ),
  );
}
