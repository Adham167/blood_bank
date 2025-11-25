import 'package:bloc/bloc.dart';
import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  void signup({required UserModel userModel}) async {
    emit(SignupLoading());
    Future.delayed(Duration(seconds: 2));
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: userModel.email!,
            password: userModel.password!,
          );

      if (userModel.name != null &&
          userModel.phone != null &&
          userModel.email != null &&
          userModel.password != null) {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userCredential.user!.uid)
            .set({
              'fullName': userModel.name,
              'phone': userModel.phone,
              'email': userModel.email,
              'password': userModel.password,
            });
      }
      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignupFailure(errMessage: "The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        emit(
          SignupFailure(
            errMessage: "The account already exists for that email.",
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
