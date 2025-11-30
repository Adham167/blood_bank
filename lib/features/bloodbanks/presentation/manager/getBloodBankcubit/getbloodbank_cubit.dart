import 'package:bloc/bloc.dart';
import 'package:blood_bank/features/bloodbanks/data/models/blood_bank_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'getbloodbank_state.dart';

class GetBloodBankCubit extends Cubit<GetBloodBankState> {
  GetBloodBankCubit() : super(GetBloodBankInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> getBloodBanks() async {
    emit(GetBloodBankLoading());
    try {
      final snapshot = await _firestore.collection('BloodBanks').get();

      final data =
          snapshot.docs.map((doc) {
            return BloodBankModel.fromMap(doc.data());
          }).toList();

      emit(GetBloodBankSuccess(bloodBanks: data));
    } catch (e) {
      emit(GetBloodBankFailure(errMessages: e.toString()));
    }
  }
}
