import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyModel {
  final String bloodType;
  final String userId;
  final String details;
  final String address;
  final Timestamp time;

  Map<String, dynamic> toMap() {
    return {
      'bloodType': bloodType,
      'userId': userId,
      'details': details,
      'address': address,
      'time': time,
    };
  }

  factory EmergencyModel.fromMap(Map<String, dynamic> map) {
    return EmergencyModel(
      bloodType: map['bloodType'],
      details: map['details'],
      userId: map['userId'],
      address: map['address'],
      time: Timestamp.now(),
    );
  }

  EmergencyModel({
    required this.bloodType,
    required this.details,
    required this.address,
    required this.userId,
    required this.time,
  });
}
