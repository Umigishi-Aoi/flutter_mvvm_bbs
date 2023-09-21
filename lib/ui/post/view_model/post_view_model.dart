import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../config/firestore_settings.dart';
import '../../../model/auth/auth_model.dart';
import '../../../model/firestore/firestore_model.dart';

class PostViewModel extends ChangeNotifier {
  PostViewModel() {
    _authModel = AuthModel.prod();
    _firestoreModel = FirestoreModel.prod();
    _controller = TextEditingController();
  }

  //テスト時に使用
  PostViewModel.withModel(
    AuthModel authModel,
    FirestoreModel firestoreModel,
    TextEditingController controller,
  ) {
    _authModel = authModel;
    _firestoreModel = firestoreModel;
    _controller = controller;
  }

  late AuthModel _authModel;
  late FirestoreModel _firestoreModel;
  late TextEditingController _controller;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  TextEditingController get controller => _controller;

  Future<void> setData() async {
    final user = _authModel.currentUser();

    if (user == null) {
      _errorMessage = 'User is null';
      return;
    }

    final data = <String, dynamic>{
      BbsField.userName.name: user.displayName,
      BbsField.post.name: _controller.text,
      BbsField.photoUrl.name: user.photoURL,
      BbsField.createdAt.name:
          Timestamp(Timestamp.fromDate(DateTime.now()).seconds, 0),
    };
    try {
      await _firestoreModel.setData(data);
    } on Exception catch (e) {
      _errorMessage = e.toString();
      return;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
