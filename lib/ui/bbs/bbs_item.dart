// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BbsItem extends StatelessWidget {
  const BbsItem({
    super.key,
    required this.userName,
    required this.post,
    required this.photoUrl,
    required this.createdAt,
  });

  final String userName;
  final String post;
  final String photoUrl;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DecoratedBox(
        decoration: BoxDecoration(border: Border.all()),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 32),
                child: ClipOval(
                  child: Image.network(
                    photoUrl,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(userName),
                          Text(createdAt),
                        ],
                      ),
                    ),
                    Text(post),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
