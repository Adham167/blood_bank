import 'package:blood_bank/features/emergency/data/models/emergency_model.dart';


abstract class EmergencyState {}

class EmergencyInitial extends EmergencyState {}
class EmergencyLoading extends EmergencyState {}
class EmergencyAddedSuccess extends EmergencyState {}
class EmergencySuccess extends EmergencyState {
  final EmergencyModel emergencyModel;
  EmergencySuccess({required this.emergencyModel});
}
class EmergencyFailure extends EmergencyState {
  final String errMessage;
  EmergencyFailure({required this.errMessage});
}
class EmergencyEmpty extends EmergencyState {}
