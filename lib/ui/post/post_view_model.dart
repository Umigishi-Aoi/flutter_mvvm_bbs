import 'package:cloud_firestore/cloud_firestore.dart';

import '../../config/firestore_settings.dart';
import '../../model/auth/auth_model.dart';
import '../../model/firestore/firestore_model.dart';

class PostViewModel {
  PostViewModel() {
    _authModel = AuthModel.prod();
    _firestoreModel = FirestoreModel.prod();
  }
  
  //テスト時に使用
  PostViewModel.withModel(
    AuthModel authModel,
    FirestoreModel firestoreModel,
  ) {
    _authModel = authModel;
    _firestoreModel = firestoreModel;
  }

  late AuthModel _authModel;
  late FirestoreModel _firestoreModel;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> setData(String post) async {
    final user = _authModel.currentUser();

    if (user == null) {
      _errorMessage = 'User is null';
      return;
    }

    final data = <String, dynamic>{
      BbsField.userName.name: user.displayName,
      BbsField.post.name: post,
      BbsField.photoUrl.name: user.photoURL,
      BbsField.createdAt.name: Timestamp.now(),
    };
    try {
      await _firestoreModel.setData(data);
    } on Exception catch (e) {
      _errorMessage = e.toString();
      return;
    }
  }
}
