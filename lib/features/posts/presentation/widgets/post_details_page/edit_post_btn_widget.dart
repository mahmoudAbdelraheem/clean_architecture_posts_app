import '../../../domain/entities/post_entity.dart';
import 'package:flutter/material.dart';

import '../../pages/add_update_posts_page.dart';

class EditPostBtnWidget extends StatelessWidget {
  final Post post;
  const EditPostBtnWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => AddUpdatePostsPage(
              isUpdatePost: true,
              post: post,
            ),
          ),
        );
      },
      icon: const Icon(Icons.edit),
      label: const Text('Edit'),
    );
  }
}
