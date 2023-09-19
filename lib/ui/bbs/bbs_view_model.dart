import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../model/firestore/firestore_model.dart';
import '../common/firestore_settings.dart';

class BbsViewModel extends ChangeNotifier {
  BbsViewModel() {
    _model = const FirestoreModel();
  }

  late FirestoreModel _model;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<Map<String, String>>? _bbsData;

  List<Map<String, String>>? get bbsData => _bbsData;

  Future<void> getAllData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot;
    try {
      snapshot = await _model.getAllData();
    } on Exception catch (e) {
      _errorMessage = e.toString();
      return;
    }
    try {
      _bbsData = snapshot.docs.map((doc) {
        final data = doc.data();
        final createdAt = data[BbsField.createdAt.name];
        if (createdAt is! Timestamp) {
          throw Exception('createdAt is not Timestamp');
        }

        final createdAtString = createdAt.toDate().toString();

        return {
          BbsField.userName.name: data[BbsField.userName.name] as String,
          BbsField.post.name: data[BbsField.post.name] as String,
          BbsField.photoUrl.name: data[BbsField.photoUrl.name] as String,
          BbsField.createdAt.name:
              createdAtString.substring(0, createdAtString.length - 7),
        };
      }).toList();
    } on Exception catch (e) {
      _errorMessage = e.toString();
      return;
    }
    notifyListeners();
  }

  Future<void> refresh() async {
    _errorMessage = null;
    await getAllData();
    notifyListeners();
  }
}
