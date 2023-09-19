import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'post_view_model.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PostViewModel(),
      child: Scaffold(
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
                  controller: controller,
                ),
                ElevatedButton(
                  onPressed: () {
                    final viewModel = context.read<PostViewModel>()
                      ..setData(controller.text);
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
      ),
    );
  }
}
