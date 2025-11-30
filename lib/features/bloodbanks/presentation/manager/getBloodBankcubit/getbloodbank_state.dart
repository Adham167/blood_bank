part of 'getbloodbank_cubit.dart';

@immutable
sealed class GetBloodBankState {}

final class GetBloodBankInitial extends GetBloodBankState {}

final class GetBloodBankLoading extends GetBloodBankState {}

final class GetBloodBankSuccess extends GetBloodBankState {
  final List<BloodBankModel> bloodBanks;

  GetBloodBankSuccess({required this.bloodBanks});
}

final class GetBloodBankFailure extends GetBloodBankState {
  final String errMessages;

  GetBloodBankFailure({required this.errMessages});
}
