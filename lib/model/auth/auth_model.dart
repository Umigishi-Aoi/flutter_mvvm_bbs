import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  const AuthModel(this.instance);

  factory AuthModel.prod() {
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
