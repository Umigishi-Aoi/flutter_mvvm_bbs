import 'package:cloud_firestore/cloud_firestore.dart';

import '../../config/firestore_settings.dart';

class FirestoreModel {
  const FirestoreModel();

  Future<void> setData(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection(Collection.bbs.name)
        .doc()
        .set(data);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllData() async {
    return FirebaseFirestore.instance
        .collection(Collection.bbs.name)
        .orderBy(BbsField.createdAt.name, descending: true)
        .get();
  }
}
