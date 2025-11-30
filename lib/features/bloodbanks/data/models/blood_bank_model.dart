class BloodBankModel {
  final String name;
  final String phone;
  final String address;
  final String timeLine;

  BloodBankModel({
    required this.name,
    required this.phone,
    required this.address,
    required this.timeLine,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'timeLine': timeLine,
    };
  }

  factory BloodBankModel.fromMap(Map<String, dynamic> map) {
    return BloodBankModel(
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
      timeLine: map['timeLine'],
    );
  }
}
