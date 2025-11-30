part of 'donor_cubit.dart';

@immutable
sealed class DonorState {}

final class DonorInitial extends DonorState {}

final class DonorLoading extends DonorState {}

final class DonorFailure extends DonorState {
  final String errMessage;

  DonorFailure({required this.errMessage});
}

final class DonorSuccess extends DonorState {
  final List<DonerModel>? doners;

  DonorSuccess({this.doners});
}
