import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/auth_view_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: context.read<AuthViewModel>().signInWithGitHub,
          child: const Text('Sign in with GitHub'),
        ),
      ),
    );
  }
}
