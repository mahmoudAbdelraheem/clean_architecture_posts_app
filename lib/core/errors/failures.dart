import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

// if user is offline
class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// can't connect to the server
class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// if local data in empty
class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}
