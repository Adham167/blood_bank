import 'package:bloc/bloc.dart';
import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:blood_bank/features/donor/data/donation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'donor_state.dart';

class DonorCubit extends Cubit<DonorState> {
  DonorCubit() : super(DonorInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<UserModel> allDonors = [];

  Future<void> getDonors() async {
    emit(DonorLoading());
    try {
      final snapshot = await _firestore.collection('Users').get();
      allDonors =
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
      emit(DonorSuccess(doners: allDonors));
    } catch (e) {
      emit(DonorFailure(errMessage: e.toString()));
    }
  }

  Future<void> filterDonors({
    required String bloodType,
    required String location,
  }) async {
    emit(DonorLoading());
    try {
      final filtered =
          allDonors.where((user) {
            final matchBlood = bloodType.isEmpty || user.bloodType == bloodType;
            final matchLocation =
                location.isEmpty ||
                (user.address ?? "").toLowerCase().contains(
                  location.toLowerCase(),
                );
            return matchBlood && matchLocation;
          }).toList();
      emit(DonorSuccess(doners: filtered));
    } catch (e) {
      emit(DonorFailure(errMessage: e.toString()));
    }
  }

  Future<void> addDonationToUser({
    required String uid,
    required DonationModel donation,
  }) async {
    emit(DonorAddingDonation());

    try {
      await _firestore
          .collection('Users')
          .doc(uid)
          .collection("donationHistory")
          .add(donation.toMap());

      await getDonationHistoryForUser(uid);

      emit(DonorDonationAdded());
    } catch (e) {
      emit(DonorFailure(errMessage: e.toString()));
    }
  }

  Future<void> getDonationHistoryForUser(String userId) async {
    try {
      final snapshot =
          await _firestore
              .collection('Users')
              .doc(userId)
              .collection('donationHistory')
              .orderBy('time', descending: true)
              .get();

      final donations =
          snapshot.docs
              .map((doc) => DonationModel.fromMap(doc.data()))
              .toList();

      emit(DonorDonationLoaded(donations: donations));
    } catch (e) {
      emit(DonorFailure(errMessage: e.toString()));
    }
  }
}
