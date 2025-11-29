import 'package:bloc/bloc.dart';
import 'package:blood_bank/features/auth/domain/entities/user_entity.dart';
import 'package:blood_bank/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());

  final AuthRepo authRepo;
  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    var result = await authRepo.signIn(email, password);
    result.fold(
      (failure) => emit(LoginFailure(errMessage: failure.message)),
      (userEntity) => emit(LoginSuccess(userEntity: userEntity)),
    );
  }
}
