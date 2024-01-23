part of 'add_update_delete_post_bloc.dart';

sealed class AddUpdateDeletePostState extends Equatable {
  const AddUpdateDeletePostState();

  @override
  List<Object> get props => [];
}

final class AddUpdateDeletePostInitial extends AddUpdateDeletePostState {}

final class LoadingAddUpdateDeletePostState extends AddUpdateDeletePostState {}

final class SuccessAddUpdateDeletePostState extends AddUpdateDeletePostState {
  final String successMessage;

  const SuccessAddUpdateDeletePostState({required this.successMessage});

  @override
  List<Object> get props => [successMessage];
}

final class ErrorAddUpdateDeletePostState extends AddUpdateDeletePostState {
  final String errorMessage;

  const ErrorAddUpdateDeletePostState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
