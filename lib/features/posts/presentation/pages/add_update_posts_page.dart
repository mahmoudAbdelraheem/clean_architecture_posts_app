import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/snakbar_message.dart';
import '../../../../core/widget/loading_widget.dart';
import '../../domain/entities/post_entity.dart';
import '../bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import '../widgets/add_update_post_page/form_widget.dart';

class AddUpdatePostsPage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const AddUpdatePostsPage({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
          listener: (context, state) {
            if (state is SuccessAddUpdateDeletePostState) {
              SnakBarMessage.showSuccessMessage(
                message: state.successMessage,
                context: context,
              );
              Navigator.of(context).pop();
            } else if (state is ErrorAddUpdateDeletePostState) {
              SnakBarMessage.showErrorMessage(
                message: state.errorMessage,
                context: context,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingAddUpdateDeletePostState) {
              return const LoadingWidget();
            } else {
              return FormWidget(
                  isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
            }
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: const BackButton(
        color: Colors.white,
      ),
      title: Text(isUpdatePost ? 'Update Post' : 'Add Post'),
    );
  }
}
