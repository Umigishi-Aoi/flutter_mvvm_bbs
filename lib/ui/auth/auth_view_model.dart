import 'package:flutter/foundation.dart';

import '../../model/auth/auth_model.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel() {
    _model = AuthModel();
    getUserInfo();
  }

  late AuthModel _model;

  String? _userName;
  String? _photoUrl;

  String? _errorMessage;

  String? get userName => _userName;
  String? get photoUrl => _photoUrl;

  String? get errorMessage => _errorMessage;

  bool get isLogin => _model.currentUser() != null;

  Future<void> signInWithGitHub() async {
    try {
      await _model.signInWithGitHub();
    } on Exception catch (e) {
      _errorMessage = e.toString();
      return;
    }

    getUserInfo();
    notifyListeners();
  }

  void getUserInfo() {
    final user = _model.currentUser();
    _userName = user?.displayName;
    _photoUrl = user?.photoURL;
  }

  Future<void> signOut() async {
    try {
      await _model.signOut();
    } on Exception catch (e) {
      _errorMessage = e.toString();
      return;
    }
    _userName = null;
    _photoUrl = null;
    notifyListeners();
  }
}
