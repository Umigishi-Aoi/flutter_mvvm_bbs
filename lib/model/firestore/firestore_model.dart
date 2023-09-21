import 'package:cloud_firestore/cloud_firestore.dart';

import '../../config/firestore_settings.dart';

class FirestoreModel {
  // テスト時はこちらでモックを渡す
  const FirestoreModel(this.instance);

  //アプリではこちらを使い、FirebaseFirestore.instanceでインスタンス化する
  factory FirestoreModel.app() {
    return FirestoreModel(FirebaseFirestore.instance);
  }

  final FirebaseFirestore instance;

  Future<void> setData(Map<String, dynamic> data) async {
    await instance.collection(Collection.bbs.name).doc().set(data);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllData() async {
    return instance
        .collection(Collection.bbs.name)
        .orderBy(BbsField.createdAt.name, descending: true)
        .get();
  }
}
