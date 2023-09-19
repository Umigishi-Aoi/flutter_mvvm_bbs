import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_view_model.dart';
import '../common/firestore_settings.dart';
import '../post/post_page.dart';
import 'bbs_item.dart';
import 'bbs_view_model.dart';

class BbsPage extends StatelessWidget {
  const BbsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BbsViewModel()..getAllData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BBS Page'),
          actions: [
            Consumer<BbsViewModel>(
              builder: (_, viewModel, __) => IconButton(
                onPressed: viewModel.refresh,
                icon: const Icon(Icons.refresh),
              ),
            ),
            Consumer<AuthViewModel>(
              builder: (_, viewModel, __) => IconButton(
                onPressed: viewModel.signOut,
                icon: const Icon(Icons.logout),
              ),
            ),
          ],
        ),
        body: Consumer<BbsViewModel>(
          builder: (_, viewModel, __) {
            if (viewModel.errorMessage != null) {
              return Center(
                child: Text(viewModel.errorMessage!),
              );
            }

            final data = viewModel.bbsData;

            if (data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (data.isEmpty) {
              return const Center(
                child: Text('No data'),
              );
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) => BbsItem(
                userName: data[index][BbsField.userName.name]!,
                post: data[index][BbsField.post.name]!,
                photoUrl: data[index][BbsField.photoUrl.name]!,
                createdAt: data[index][BbsField.createdAt.name]!,
              ),
            );
          },
        ),
        floatingActionButton: Consumer<BbsViewModel>(
          builder: (_, viewModel, __) => FloatingActionButton(
            onPressed: () async {
              await Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (_) => const PostPage(),
                ),
              );
              await viewModel.refresh();
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
