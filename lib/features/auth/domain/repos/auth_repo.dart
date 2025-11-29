import 'package:blood_bank/core/errors/failure.dart';
import 'package:blood_bank/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> signUp(
    String email,
    String password,
    String name,
  );
  Future<Either<Failure, UserEntity>> signIn(String email, String password);
  Future addUserData({required UserEntity user});
  Future<UserEntity> getUserData({required String uid});
}
