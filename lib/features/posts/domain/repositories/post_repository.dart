import '../../../../core/errors/failures.dart';
import '../entities/post_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
//unit its like void don't return anything
  Future<Either<Failure, Unit>> deletePost(int postId);

  Future<Either<Failure, Unit>> updatePost(Post post);

  Future<Either<Failure, Unit>> addPost(Post post);
}

//Future<fail , List<Post>> using dartz
//it return either left on fail ,right on success
