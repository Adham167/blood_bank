import 'package:blood_bank/core/service/data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService implements DataService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    // 🔥 التصحيح: استخدام doc() بدلاً من add()
    // path المفروض يكون "Users/user123"
    if (path.contains('/')) {
      final parts = path.split('/');
      if (parts.length >= 2) {
        // parts[0] = "Users", parts[1] = "user123"
        await firestore.collection(parts[0]).doc(parts[1]).set(data);
      } else {
        throw Exception('Invalid path format: $path');
      }
    } else {
      // إذا كان path بدون document ID (مش مستحسن)
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future<Map<String, dynamic>> getData({
    required String path,
    required String documentId,
  }) async {
    var data = await firestore.collection(path).doc(documentId).get();
    return data.data() as Map<String, dynamic>;
  }
}