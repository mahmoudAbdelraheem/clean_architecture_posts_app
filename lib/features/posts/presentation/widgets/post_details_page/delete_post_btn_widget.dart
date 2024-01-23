import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/snakbar_message.dart';
import '../../../../../core/widget/loading_widget.dart';
import '../../../domain/entities/post_entity.dart';
import '../../bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import '../../pages/posts_page.dart';
import 'delete_dialog_widget.dart';

class DEletePostBtnWidget extends StatelessWidget {
  final Post post;
  const DEletePostBtnWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.redAccent),
      ),
      onPressed: () => deleteDialog(context, post.id!),
      icon: const Icon(Icons.delete),
      label: const Text('Delete'),
    );
  }

  void deleteDialog(BuildContext context, int postId) {
    showDialog(
      context: context,
      builder: ((context) {
        return BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
          listener: (context, state) {
            if (state is SuccessAddUpdateDeletePostState) {
              SnakBarMessage.showSuccessMessage(
                  message: state.successMessage, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const PostsPage()),
                  (route) => false);
            } else if (state is ErrorAddUpdateDeletePostState) {
              Navigator.pop(context);
              SnakBarMessage.showErrorMessage(
                  message: state.errorMessage, context: context);
            }
          },
          builder: (context, state) {
            if (state is LoadingAddUpdateDeletePostState) {
              return const AlertDialog(
                title: LoadingWidget(),
              );
            }
            return DeleteDialogWidget(postId: postId);
          },
        );
      }),
    );
  }
}
