import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_view_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<AuthViewModel>(
          builder: (context, viewModel, _) => ElevatedButton(
            onPressed: viewModel.signInWithGitHub,
            child: const Text('Sign in with GitHub'),
          ),
        ),
      ),
    );
  }
}
