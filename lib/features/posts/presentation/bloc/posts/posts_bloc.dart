import 'package:clean_architecture_posts_app/core/errors/error_massage.dart';
import 'package:clean_architecture_posts_app/core/errors/failures.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/get_all_posts.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;
  PostsBloc({required this.getAllPostsUseCase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(LoadingPostState());

        final failureOrPosts = await getAllPostsUseCase();

        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
      // } else if (event is RefreshPostsEvent) {
      //   emit(LoadingPostState());

      //   final failureOrPosts = await getAllPostsUseCase();

      //   emit(_mapFailureOrPostsToState(failureOrPosts));
      // }
    });
  }
// get loaded post state or error post state
  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    //fold form dartz and it's return left ,rigth of either...
    return either.fold(
        (failure) => ErrorPostState(message: _getErrorMessage(failure)),
        (posts) => LoadedPostState(posts: posts));
  }

  // get error massage based on error failure
  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ErrorMassage.serverErrorMsg;
      case EmptyCacheFailure:
        return ErrorMassage.emptyCacheErrorMsg;
      case OfflineFailure:
        return ErrorMassage.offlineErrorMsg;

      default:
        return ErrorMassage.unexpectedErrorMsg;
    }
  }
}
