import '../../bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'form_submit_bto.dart';
import 'text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/post_entity.dart';

class FormWidget extends StatefulWidget {
  final Post? post;
  final bool isUpdatePost;
  const FormWidget({super.key, this.post, required this.isUpdatePost});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    titleController.dispose();
    bodyController.dispose();
  }

  void validateFormThenAddOrUpdatePost() {
    final bool isValid = formState.currentState!.validate();
    if (isValid) {
      final Post post = Post(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: titleController.text,
        body: bodyController.text,
      );
      if (widget.isUpdatePost) {
        BlocProvider.of<AddUpdateDeletePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddUpdateDeletePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //! title textform
          TextFormFieldWidget(
              controller: titleController, name: 'title', multiLine: false),
          //! body textform

          TextFormFieldWidget(
              controller: bodyController, name: 'Body', multiLine: true),
          //? submit btn(add,update)

          FormSubmitBtn(
              isUpdatePost: widget.isUpdatePost,
              onPressed: validateFormThenAddOrUpdatePost),
        ],
      ),
    );
  }
}
