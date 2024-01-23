import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/add_post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/update_post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/error_massage.dart';
import '../../../../../core/errors/failures.dart';
import '../../../domain/usecases/delete_post.dart';

part 'add_update_delete_post_event.dart';
part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostBloc
    extends Bloc<AddUpdateDeletePostEvent, AddUpdateDeletePostState> {
  final AddPostsUseCase addPost;
  final DeletePostsUseCase deletePost;
  final UpdatePostsUseCase updatePost;

  AddUpdateDeletePostBloc({
    required this.addPost,
    required this.deletePost,
    required this.updatePost,
  }) : super(AddUpdateDeletePostInitial()) {
    on<AddUpdateDeletePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        // loading state
        emit(LoadingAddUpdateDeletePostState());
        // add data
        final failureOrDoneMessage = await addPost.call(event.post);
        // emit error state or success state
        emit(_mapFailureOrDoneMassageToState(failureOrDoneMessage, 'add'));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddUpdateDeletePostState());

        final failureOrDoneMessage = await deletePost.call(event.id);

        emit(_mapFailureOrDoneMassageToState(failureOrDoneMessage, 'delete'));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddUpdateDeletePostState());

        final failureOrDoneMessage = await updatePost.call(event.post);

        emit(_mapFailureOrDoneMassageToState(failureOrDoneMessage, 'update'));
      }
    });
  }
  //get error state of sussess state based on failure or done massage (add,update , delete)
  AddUpdateDeletePostState _mapFailureOrDoneMassageToState(
    Either<Failure, Unit> either,
    String s,
  ) {
    return either.fold(
      (failure) => ErrorAddUpdateDeletePostState(
        errorMessage: _getErrorMassage(failure),
      ),
      (r) => SuccessAddUpdateDeletePostState(
        successMessage: _getSuccessMassage(s),
      ),
    );
  }

  // get error massage based on error failure
  String _getErrorMassage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ErrorMassage.serverErrorMsg;
      case OfflineFailure:
        return ErrorMassage.offlineErrorMsg;

      default:
        return ErrorMassage.unexpectedErrorMsg;
    }
  }

  // get success massage based on error failure
  String _getSuccessMassage(String s) {
    switch (s) {
      case 'add':
        return SuccessMessage.addPostSuccessMsg;
      case 'delete':
        return SuccessMessage.deletePostSuccessMsg;
      case 'update':
        return SuccessMessage.updatePostSuccessMsg;

      default:
        return 'Done';
    }
  }
}
