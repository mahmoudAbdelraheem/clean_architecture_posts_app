import 'package:clean_architecture_posts_app/features/posts/domain/entities/post_entity.dart';
import 'package:flutter/material.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (_, index) => _buildListTilePost(posts[index]),
      separatorBuilder: (_, index) => _buildPostDivider(),
    );
  }

  // build Single Post
  Widget _buildListTilePost(Post post) {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        child: Text(
          post.id.toString(),
          style: const TextStyle(fontSize: 16),
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
