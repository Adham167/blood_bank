import 'package:bloc/bloc.dart';
import 'package:blood_bank/features/auth/domain/entities/user_entity.dart';
import 'package:blood_bank/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo;

  Future<void> signUp(String email, String password, String name,String phone,String bloodType,String address) async {
    emit(SignupLoading());
    var result = await authRepo.signUp(email, password, name,phone,bloodType,address);

    result.fold(
      (failure) => emit(SignupFailure(errMessage: failure.message)),
      (userentity) => emit(SignupSuccess(userEntity: userentity)),
    );
  }
  // void signup({required UserModel userModel}) async {
  //   emit(SignupLoading());
  //   Future.delayed(Duration(seconds: 2));
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //           email: userModel.email!,
  //           password: userModel.password!,
  //         );

  //     if (userModel.name != null &&
  //         userModel.phone != null &&
  //         userModel.email != null &&
  //         userModel.password != null) {
  //       await FirebaseFirestore.instance
  //           .collection("Users")
  //           .doc(userCredential.user!.uid)
  //           .set({
  //             'fullName': userModel.name,
  //             'phone': userModel.phone,
  //             'email': userModel.email,
  //             'password': userModel.password,
  //           });
  //     }
  //     emit(SignupSuccess());
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       emit(SignupFailure(errMessage: "The password provided is too weak."));
  //     } else if (e.code == 'email-already-in-use') {
  //       emit(
  //         SignupFailure(
  //           errMessage: "The account already exists for that email.",
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
