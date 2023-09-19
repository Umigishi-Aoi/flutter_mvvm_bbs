import 'package:flutter/foundation.dart';

import '../../model/auth/auth_model.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel() {
    _model = const AuthModel();
  }

  late AuthModel _model;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool get isLogin => _model.currentUser() != null;

  Future<void> signInWithGitHub() async {
    try {
      await _model.signInWithGitHub();
    } on Exception catch (e) {
      _errorMessage = e.toString();
      return;
    }

    notifyListeners();
  }

  Future<void> signOut() async {
    try {
      await _model.signOut();
    } on Exception catch (e) {
      _errorMessage = e.toString();
      return;
    }
    notifyListeners();
  }
}
