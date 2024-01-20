import '../entities/post_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/post_repository.dart';

class AddPostsUseCase {
  final PostRepository repository;

  AddPostsUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}
