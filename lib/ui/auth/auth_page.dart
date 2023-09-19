import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_view_model.dart';
import 'sign_in_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: Consumer<AuthViewModel>(
        builder: (context, viewModel, _) {
          return viewModel.isLogin
              ? Scaffold(
                  appBar: AppBar(
                    actions: [
                      IconButton(
                        onPressed: viewModel.signOut,
                        icon: const Icon(Icons.logout),
                      ),
                    ],
                  ),
                )
              : const SignInPage();
        },
      ),
    );
  }
}
