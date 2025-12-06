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
    final timeData = map['time'];
    DateTime parsedTime;

    if (timeData is Timestamp) {
      parsedTime = timeData.toDate();
    } else if (timeData is String) {
      parsedTime = DateTime.tryParse(timeData) ?? DateTime.now();
    } else {
      parsedTime = DateTime.now();
    }

    return DonationModel(
      time: parsedTime,
      address: map['address'] ?? '',
      donationType: map['donationType'] ?? '',
    );
  }
}
