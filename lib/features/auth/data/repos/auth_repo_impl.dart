import 'dart:developer';

import 'package:blood_bank/core/errors/exceptions.dart';
import 'package:blood_bank/core/errors/failure.dart';
import 'package:blood_bank/core/service/firebase_auth_service.dart';
import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:blood_bank/features/auth/domain/entities/user_entity.dart';
import 'package:blood_bank/features/auth/domain/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;

  AuthRepoImpl({required this.firebaseAuthService});
  @override
  Future<Either<Failure, UserEntity>> signUp(
    String email,
    String password,
    String name,
  ) async {
    try {
      var user = await firebaseAuthService.signUp(
        email: email,
        password: password,
      );
      return right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log("Exception in sign up : ${e.toString()}");
      return left(ServerFailure("An error accured !!"));
    }
  }
}
