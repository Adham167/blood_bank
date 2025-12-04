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

  /// Get all donors (Users)
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

  /// Filter donors by bloodType + location
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

  /// Add donation record for a specific user
  Future<void> addDonationToUser({
    required String uid,
    required DonationModel donation,
  }) async {
    emit(DonorAddingDonation()); // ✅ state جديد
    try {
      // 1. إضافة التبرع الجديد
      await _firestore
          .collection('Users')
          .doc(uid)
          .collection("donationHistory")
          .add(donation.toMap());

      // 2. جلب تاريخ التبرعات المحدث مباشرة
      await getDonationHistoryForUser(uid);

      // 3. إرسال state نجاح
      emit(DonorDonationAdded()); // ✅ نجاح الإضافة
    } catch (e) {
      emit(DonorFailure(errMessage: e.toString()));
    }
  }

  /// Load donation history for user
  Future<void> getDonationHistoryForUser(String userId) async {
    emit(DonorLoading());
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
