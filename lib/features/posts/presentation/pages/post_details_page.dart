import '../../domain/entities/post_entity.dart';
import 'package:flutter/material.dart';

import '../widgets/post_details_page/post_details_widget.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;
  const PostDetailsPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: PostDetailsWidget(post: post),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Post Details'),
    );
  }
}
