import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  void login({required String email, required String password}) async {
    emit(LoginLoading());
    await Future.delayed(Duration(seconds: 2));
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errMessage: "user not found"));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errMessage: "wrong password"));
      }
    }
  }
}
