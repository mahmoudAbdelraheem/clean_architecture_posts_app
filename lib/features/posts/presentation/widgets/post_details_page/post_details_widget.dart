import 'delete_post_btn_widget.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/post_entity.dart';
import 'edit_post_btn_widget.dart';

class PostDetailsWidget extends StatelessWidget {
  final Post post;
  const PostDetailsWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Divider(height: 50),
          Text(
            post.body,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const Divider(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EditPostBtnWidget(post: post),
              DEletePostBtnWidget(post: post),
            ],
          ),
        ],
      ),
    );
  }
}
