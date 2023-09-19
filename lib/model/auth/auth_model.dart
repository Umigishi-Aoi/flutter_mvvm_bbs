import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  const AuthModel();

  Future<void> signInWithGitHub() async {
    final githubProvider = GithubAuthProvider();
    await FirebaseAuth.instance.signInWithProvider(githubProvider);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User? currentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
