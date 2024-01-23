import '../../../../../core/app_theme.dart';
import '../../../domain/entities/post_entity.dart';
import '../../pages/post_details_page.dart';
import 'package:flutter/material.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context, index) =>
          _buildListTilePost(posts[index], context),
      separatorBuilder: (_, index) => _buildPostDivider(),
    );
  }

  // build Single Post
  Widget _buildListTilePost(Post post, BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PostDetailsPage(post: post),
          ),
        );
      },
      leading: CircleAvatar(
        backgroundColor: primaryColor,
        child: Text(
          post.id.toString(),
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      title: Text(
        post.title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        post.body,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    );
  }

  Widget _buildPostDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Divider(
        thickness: 1,
        color: Colors.grey,
      ),
    );
  }
}
