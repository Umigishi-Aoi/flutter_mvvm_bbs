import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bbs/bbs_page.dart';
import '../common/error_page.dart';
import 'auth_view_model.dart';
import 'sign_in_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: Consumer<AuthViewModel>(
        builder: (_, viewModel, __) {
          final errorMessage = viewModel.errorMessage;
          if (errorMessage != null) {
            return ErrorPage(message: errorMessage);
          }
          return viewModel.isLogin ? const BbsPage() : const SignInPage();
        },
      ),
    );
  }
}
