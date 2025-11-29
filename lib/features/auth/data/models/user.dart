import 'package:blood_bank/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  UserModel({required super.name, required super.email, required super.uid});
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      name: user.displayName ?? "",
      email: user.email ?? "",
      uid: user.uid,
    );
  }
  factory UserModel.fromJson(Map<String, dynamic> Json) {
    return UserModel(
      name: Json['name'],
      email: Json['email'],
      uid: Json['uid'],
    );
  }
}
