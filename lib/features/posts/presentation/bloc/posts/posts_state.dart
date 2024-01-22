part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}

final class LoadingPostState extends PostsState {}

final class LoadedPostState extends PostsState {
  final List<Post> posts;

  const LoadedPostState({required this.posts});

  @override
  List<Object> get props => [posts];
}

final class ErrorPostState extends PostsState {
  final String massage;

  const ErrorPostState({required this.massage});

  @override
  List<Object> get props => [massage];
}
