import '../entities/post_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/post_repository.dart';

class UpdatePostsUseCase {
  final PostRepository repository;

  UpdatePostsUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}
