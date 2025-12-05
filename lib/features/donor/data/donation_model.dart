import 'package:cloud_firestore/cloud_firestore.dart';

class DonationModel {
  final DateTime time;
  final String address;
  final String donationType;

  DonationModel({
    required this.time,
    required this.address,
    required this.donationType,
  });
  Map<String, dynamic> toMap() {
    return {
      'time': Timestamp.fromDate(time),
      'address': address,
      'donationType': donationType,
    };
  }

  factory DonationModel.fromMap(Map<String, dynamic> map) {
    return DonationModel(
      time: (map['time'] as Timestamp).toDate(),
      address: map['address'],
      donationType: map['donationType'],
    );
  }
}
