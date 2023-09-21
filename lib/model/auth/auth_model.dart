import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  // テスト時はこちらでモックを渡す
  const AuthModel(this.instance);

  //アプリではこちらを使い、FirebaseAuth.instanceでインスタンス化する
  factory AuthModel.app() {
    return AuthModel(FirebaseAuth.instance);
  }

  final FirebaseAuth instance;

  Future<void> signInWithGitHub() async {
    final githubProvider = GithubAuthProvider();
    await instance.signInWithProvider(githubProvider);
  }

  Future<void> signOut() async {
    await instance.signOut();
  }

  User? currentUser() {
    return instance.currentUser;
  }
}
