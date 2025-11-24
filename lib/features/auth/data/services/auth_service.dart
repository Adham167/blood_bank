import 'package:blood_bank/core/constants/show_snack_bar.dart';
import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:blood_bank/features/auth/presentation/views/login_view.dart';
import 'package:blood_bank/presentation/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthService {
  static signin(
    context, {
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ShowSnackBar.ShowSnackBarMessage(context, "Logging in Success");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ShowSnackBar.ShowSnackBarErrMessage(context, "user not found");
      } else if (e.code == 'wrong-password') {
        ShowSnackBar.ShowSnackBarErrMessage(context, "wrong password");
      }
    }
  }

  static signUp(context, UserModel userModel) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: userModel.email!,
            password: userModel.password!,
          );
      ShowSnackBar.ShowSnackBarMessage(
        context,
        "Creating Account Successfully",
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ShowSnackBar.ShowSnackBarErrMessage(
          context,
          "The password provided is too weak.",
        );
      } else if (e.code == 'email-already-in-use') {
        ShowSnackBar.ShowSnackBarErrMessage(
          context,
          "The account already exists for that email.",
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
