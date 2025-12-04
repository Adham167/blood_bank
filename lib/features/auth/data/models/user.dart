import 'package:blood_bank/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.address,
    required super.bloodType,
    required super.uid,
    required super.phone,
  });
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      name: user.displayName ?? "",
      email: user.email ?? "",
      phone: user.phoneNumber ?? "",

      uid: user.uid,
      address: '',
      bloodType: '',
    );
  }
  factory UserModel.fromJson(Map<String, dynamic> Json) {
    return UserModel(
      name: Json['name'],
      email: Json['email'],
      phone: Json['phone'],
      bloodType: Json['bloodType'],
      address: Json['address'],
      uid: Json['uid'],
    );
  }
}
