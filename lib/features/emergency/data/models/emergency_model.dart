
class EmergencyModel {
  final String bloodType;
  final String details;
  // final String address;

  EmergencyModel({
    required this.bloodType,
    required this.details,
    // required this.address,
  });
  factory EmergencyModel.fromJson(Json) {
    return EmergencyModel(
      bloodType: Json['bloodType'],
      details: Json['details'],
      // address: address,
    );
  }
}
