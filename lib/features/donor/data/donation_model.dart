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
    return {'time': time.toIso8601String(), 'address': address, 'donationType': donationType};
  }

  factory DonationModel.fromMap(Map<String, dynamic> map) {
    return DonationModel(
      time: DateTime.parse(map['time']),
      address: map['address'],
      donationType: map['donationType'],
    );
  }
}
