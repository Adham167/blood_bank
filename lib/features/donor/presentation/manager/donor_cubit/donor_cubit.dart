import 'package:bloc/bloc.dart';
import 'package:blood_bank/features/donor/data/doner_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'donor_state.dart';

class DonorCubit extends Cubit<DonorState> {
  DonorCubit() : super(DonorInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDonor(DonerModel doner) async {
    emit(DonorLoading());
    try {
      await _firestore.collection("Donors").add(doner.toMap());
      emit(DonorSuccess());
    } catch (e) {
      emit(DonorFailure(errMessage: e.toString()));
    }
  }

  Future<void> getDonors() async {
    emit(DonorLoading());
    try {
      final snapshot = await _firestore.collection('Donors').get();

      final data =
          snapshot.docs.map((doc) {
            return DonerModel.fromMap(doc.data());
          }).toList();
      emit(DonorSuccess(doners: data));
    } catch (e) {
      emit(DonorFailure(errMessage: e.toString()));
    }
  }
}
