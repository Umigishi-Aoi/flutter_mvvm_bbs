import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:fluter_mvvm_bbs/model/auth/auth_model.dart';
import 'package:fluter_mvvm_bbs/ui/auth/view_model/auth_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final authModel = AuthModel(MockFirebaseAuth());

  final authViewModel = AuthViewModel.withModel(authModel);

  group('AuthViewModel Test', () {
    test('sign in test', () {
      expect(authViewModel.isLogin, false);

      authViewModel.signInWithGitHub();

      expect(authViewModel.isLogin, true);
    });

    test('sign out test', () {
      authViewModel.signInWithGitHub();
      expect(authViewModel.isLogin, true);

      authViewModel.signOut();
      expect(authViewModel.isLogin, false);
    });
  });
}
