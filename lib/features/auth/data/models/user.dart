import 'package:blood_bank/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  UserModel({required super.name, required super.phone, required super.email});
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      name: user.displayName ?? "",
      phone: user.phoneNumber ?? "",
      email: user.email ?? "",
    );
  }
}
