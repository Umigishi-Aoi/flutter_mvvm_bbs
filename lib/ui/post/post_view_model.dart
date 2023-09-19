import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/auth/auth_model.dart';
import '../../model/firestore/firestore_model.dart';
import '../common/firestore_settings.dart';

class PostViewModel {
  PostViewModel() {
    _authModel = const AuthModel();
    _firestoreModel = const FirestoreModel();
    final user = _authModel.currentUser();
    _userName = user?.displayName;
    _photoUrl = user?.photoURL;
  }

  late AuthModel _authModel;
  late FirestoreModel _firestoreModel;

  String? _userName;
  String? _photoUrl;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> setData(String post) async {
    final data = <String, dynamic>{
      BbsField.userName.name: _userName,
      BbsField.post.name: post,
      BbsField.photoUrl.name: _photoUrl,
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
