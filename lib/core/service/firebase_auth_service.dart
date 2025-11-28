import 'dart:developer';

import 'package:blood_bank/core/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  Future<User> signUp({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService . sign up : ${e.toString()}");
      if (e.code == 'weak-password') {
        throw CustomException(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
          message: 'The account already exists for that email.',
        );
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'check the newtork !.');
      } else {
        throw CustomException(message: "An error accured !!");
      }
    } catch (e) {
      log("Exception in FirebaseAuthService . sign up : ${e.toString()}");

      throw CustomException(message: "An error accured !!");
    }
  }
}
