import 'package:bloc/bloc.dart';
import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:blood_bank/features/donor/data/donation_model.dart';
import 'package:blood_bank/features/donor/data/doner_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'donor_state.dart';

class DonorCubit extends Cubit<DonorState> {
  DonorCubit() : super(DonorInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<void> addDonor(DonerModel doner) async {
  //   emit(DonorLoading());
  //   try {
  //     await _firestore.collection("Donors").add(doner.toMap());
  //     final snapshot = await _firestore.collection('Donors').get();

  //     final data =
  //         snapshot.docs.map((doc) {
  //           return DonerModel.fromMap(doc.data(), doc.id);
  //         }).toList();
  //     emit(DonorSuccess(doners: data));
  //   } catch (e) {
  //     emit(DonorFailure(errMessage: e.toString()));
  //   }
  // }

  Future<void> getDonors() async {
    emit(DonorLoading());
    try {
      final snapshot = await _firestore.collection('Users').get();

      final data =
          snapshot.docs.map((doc) {
            return UserModel.fromJson(doc.data());
          }).toList();

      emit(DonorSuccess(doners: data));
    } catch (e) {
      emit(DonorFailure(errMessage: e.toString()));
    }
  }

  Future<void> addDonationToUser({
    required String uid,
    required DonationModel donation,
  }) async {
    emit(DonorLoading()); // لو عايز تظهر لودنج أثناء الإضافة
    try {
      // ضيف الدونيشن في sub-collection جوه اليوزر
      await _firestore
          .collection('Users')
          .doc(uid)
          .collection('donationHistory') // أو donations حسب ما تحب
          .add(donation.toMap());

      // بعد ما نضيف ممكن نجيب كل اليوزرس تاني لو حابب
      await getDonors();
    } catch (e) {
      emit(DonorFailure(errMessage: e.toString()));
    }
  }

  Future<void> getDonationHistoryForUser(String userId) async {
  emit(DonorLoading());
  try {
    final snapshot = await _firestore
        .collection('Users')
        .doc(userId)
        .collection('donationHistory')
        .get();

    final donations = snapshot.docs.map((doc) => DonationModel.fromMap(doc.data())).toList();
    emit(DonorDonationLoaded(donations: donations));
  } catch (e) {
    emit(DonorFailure(errMessage: e.toString()));
  }
}

}
