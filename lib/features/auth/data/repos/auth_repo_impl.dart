import 'dart:developer';

import 'package:blood_bank/core/errors/exceptions.dart';
import 'package:blood_bank/core/errors/failure.dart';
import 'package:blood_bank/core/service/data_service.dart';
import 'package:blood_bank/core/service/firebase_auth_service.dart';
import 'package:blood_bank/core/utils/backend_endpoint.dart';
import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:blood_bank/features/auth/domain/entities/user_entity.dart';
import 'package:blood_bank/features/auth/domain/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DataService dataService;

  AuthRepoImpl({required this.firebaseAuthService, required this.dataService});

  @override
  Future<Either<Failure, UserEntity>> signUp(
    String email,
    String password,
    String name,
    String phone,
    String bloodType,
    String address,
  ) async {
    User? user;
    try {
      var user = await firebaseAuthService.signUp(
        email: email,
        password: password,
      );
      var userEntity = UserEntity(
        name: name,
        uid: user.uid,
        email: email,
        phone: phone,
        bloodType: bloodType,
        address: address,
      );
      await addUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log("Exception in sign up : ${e.toString()}");
      return left(ServerFailure("An error accured !!"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(
    String email,
    String password,
  ) async {
    try {
      var user = await firebaseAuthService.signIn(
        email: email,
        password: password,
      );
      return right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log("Exception in sign in : ${e.toString()}");

      return left(ServerFailure("An error accured !!"));
    }
  }

  @override
  Future addUserData({required UserEntity user}) async {
    await dataService.addData(
      path: BackendEndpoint.addUserData,
      data: user.toMap(),
    );
  }

  @override
  Future<UserEntity> getUserData({required String uid}) async {
    var userData = await dataService.getData(
      path: BackendEndpoint.getUserData,
      documentId: uid,
    );
    return UserModel.fromJson(userData);
  }
}
