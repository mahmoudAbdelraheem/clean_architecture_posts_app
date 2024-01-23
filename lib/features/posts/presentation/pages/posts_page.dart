import '../bloc/posts/posts_bloc.dart';
import 'add_update_posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/loading_widget.dart';
import '../widgets/posts_page/message_display_widget.dart';
import '../widgets/posts_page/post_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const AddUpdatePostsPage(isUpdatePost: false),
          ),
        );
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Posts'),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (BuildContext context, PostsState state) {
          if (state is LoadingPostState) {
            return const LoadingWidget();
          } else if (state is LoadedPostState) {
            return RefreshIndicator(
              onRefresh: () => _refreshAllPosts(context),
              child: PostListWidget(
                posts: state.posts,
              ),
            );
          } else if (state is ErrorPostState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Future<void> _refreshAllPosts(BuildContext context) async {
    return BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }
}
