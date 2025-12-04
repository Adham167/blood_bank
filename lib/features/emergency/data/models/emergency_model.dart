import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyModel {
  final String userId; // ✅ ID المستخدم الذي طلب حالة الطوارئ
  final String bloodType;
  final String details;
  final String address;
  final Timestamp time;

  EmergencyModel({
    required this.userId,
    required this.bloodType,
    required this.details,
    required this.address,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'bloodType': bloodType,
      'details': details,
      'address': address,
      'time': time,
    };
  }

  factory EmergencyModel.fromMap(Map<String, dynamic> map) {
    return EmergencyModel(
      userId: map['userId'] ?? '',
      bloodType: map['bloodType'] ?? '',
      details: map['details'] ?? '',
      address: map['address'] ?? '',
      time: map['time'] ?? Timestamp.now(),
    );
  }
}