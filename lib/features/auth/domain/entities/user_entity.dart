class UserEntity {
  final String name;
  final String uid;
  final String email;

  UserEntity({required this.name, required this.uid, required this.email});
  toMap() {
    return {'name': name, 'uid': uid, 'email': email};
  }
}
