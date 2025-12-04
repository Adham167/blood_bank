import 'package:blood_bank/features/emergency/data/models/emergency_model.dart';
import 'package:blood_bank/features/emergency/presentation/manager/emergency_cubit/emergency_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmergencyCubit extends Cubit<EmergencyState> {
  EmergencyCubit() : super(EmergencyInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addEmergency(EmergencyModel emergency) async {
    emit(EmergencyLoading());
    try {
      await _firestore.collection("Emergencies").add(emergency.toMap());
      emit(EmergencyAddedSuccess());
    } catch (e) {
      emit(EmergencyFailure(errMessage: e.toString()));
    }
  }

  Future<void> getLatestEmergency() async {
    emit(EmergencyLoading());
    try {
      final snapshot =
          await _firestore
              .collection('Emergencies')
              .orderBy('time', descending: true)
              .limit(1) // هنا بنجيب أحدث مستند بس
              .get();

      if (snapshot.docs.isNotEmpty) {
        final latest = EmergencyModel.fromMap(snapshot.docs.first.data());
        emit(EmergencySuccess(emergencyModel: latest));
      } else {
        emit(EmergencyEmpty());
      }
    } catch (e) {
      emit(EmergencyFailure(errMessage: e.toString()));
    }
  }
}
