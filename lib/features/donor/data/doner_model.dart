import 'package:blood_bank/features/donor/data/donation_model.dart';

class DonerModel {
  final String name;
  final String? id;
  final String bloodType;
  final String phone;
  final String address;
  final List<DonationModel> donationHistory;

  DonerModel({
    required this.name,
    this.id,
    required this.bloodType,
    required this.phone,
    required this.address,
    required this.donationHistory,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'bloodType': bloodType,
      'phone': phone,
      'address': address,
      'donationHistory': donationHistory.map((e) => e.toMap()).toList(),
    };
  }

  factory DonerModel.fromMap(Map<String, dynamic> map, String docId) {
    return DonerModel(
      id: docId,
      name: map['name'] ?? "",
      bloodType: map['bloodType'] ?? "",
      phone: map['phone'] ?? "",
      address: map['address'] ?? "",
      donationHistory:
          map['donationHistory'] == null
              ? []
              : List<DonationModel>.from(
                (map['donationHistory'] as List).map(
                  (e) => DonationModel.fromMap(e as Map<String, dynamic>),
                ),
              ),
    );
  }
}
