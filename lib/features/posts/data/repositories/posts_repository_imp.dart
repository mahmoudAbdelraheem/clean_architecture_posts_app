import 'package:clean_architecture_posts_app/core/errors/exceptions.dart';
import 'package:clean_architecture_posts_app/core/errors/failures.dart';
import 'package:clean_architecture_posts_app/core/network/internet_info.dart';
import 'package:clean_architecture_posts_app/features/posts/data/models/post_model.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';

typedef AddOrUpdateOrDeletePost = Future<Unit> Function();

class PostsRepositoryImp implements PostRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final InternetInfo internetInfo;

  PostsRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.internetInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    //if device is connected to the internet
    if (await internetInfo.isConnected) {
      try {
        // get data from internet
        final remotePosts = await remoteDataSource.getAllPosts();
        // store data in local cache
        localDataSource.cachePosts(remotePosts);

        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
      // if device is offline
    } else {
      try {
        //get data from cached posts
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        // if cache is empty
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    //put post entity to post model
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMassage(() => remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    //put post entity to post model
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMassage(() => remoteDataSource.updatePost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMassage(() => remoteDataSource.deletePost(postId));
  }

  //
  Future<Either<Failure, Unit>> _getMassage(
      AddOrUpdateOrDeletePost addOrUpdateOrDeletePost) async {
    //if device is connected
    if (await internetInfo.isConnected) {
      try {
        await addOrUpdateOrDeletePost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    //if device is offline
    else {
      return Left(OfflineFailure());
    }
  }
}
