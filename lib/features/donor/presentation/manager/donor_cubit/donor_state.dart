part of 'donor_cubit.dart';

@immutable
sealed class DonorState {}

final class DonorInitial extends DonorState {}

final class DonorLoading extends DonorState {}
final class DonorDonationLoaded extends DonorState {
  final List<DonationModel> donations;
  DonorDonationLoaded({required this.donations});
}

final class DonorFailure extends DonorState {
  final String errMessage;

  DonorFailure({required this.errMessage});
}

final class DonorSuccess extends DonorState {
  final List<UserModel> doners;

  DonorSuccess({required this.doners});

}
