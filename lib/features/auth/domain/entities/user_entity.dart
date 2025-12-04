class UserEntity {
  final String name;
  final String uid;
  final String email;
  final String phone;
  final String bloodType;
  final String address;

  UserEntity({required this.name, required this.uid, required this.email, required this.phone, required this.bloodType, required this.address});


  toMap() {
    return {'name': name, 'uid': uid, 'email': email,'phone':phone,'bloodType':bloodType,'address':address};
  }
}
