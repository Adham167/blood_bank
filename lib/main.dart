import 'package:blood_bank/core/app/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp.router(
    routerConfig: AppRouter.router,
    debugShowCheckedModeBanner: false,));
}
