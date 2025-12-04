import 'package:blood_bank/features/emergency/data/models/emergency_model.dart';
import 'package:equatable/equatable.dart';

abstract class EmergencyState extends Equatable {
  const EmergencyState();

  @override
  List<Object> get props => [];
}

class EmergencyInitial extends EmergencyState {}

class EmergencyLoading extends EmergencyState {}

class EmergencySuccess extends EmergencyState {
  final EmergencyModel emergencyModel;
  const EmergencySuccess({required this.emergencyModel});

  @override
  List<Object> get props => [emergencyModel];
}

class EmergencyEmpty extends EmergencyState {}

class EmergencyAddedSuccess extends EmergencyState {}

class EmergencyFailure extends EmergencyState {
  final String errMessage;
  const EmergencyFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
