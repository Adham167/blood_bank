import 'package:blood_bank/core/service/firebase_auth_service.dart';
import 'package:blood_bank/features/auth/data/repos/auth_repo_impl.dart';
import 'package:blood_bank/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(firebaseAuthService: getIt<FirebaseAuthService>()),
  );
}
