import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/post_view_model.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostViewModel(),
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('新規投稿'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(64),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    maxLength: 150,
                    maxLines: 5,
                    minLines: 1,
                    controller: context.read<PostViewModel>().controller,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final viewModel = context.read<PostViewModel>()
                        ..setData();
                      final errorMessage = viewModel.errorMessage;
                      if (errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(errorMessage),
                          ),
                        );
                        return;
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('投稿する'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
