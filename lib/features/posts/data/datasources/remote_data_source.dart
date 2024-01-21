import 'package:clean_architecture_posts_app/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int id);

  Future<Unit> updatePost(PostModel postModel);

  Future<Unit> addPost(PostModel postModel);
}

class RemoteDataSourceImp implements RemoteDataSource {
  @override
  Future<Unit> addPost(PostModel postModel) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<Unit> deletePost(int id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost(PostModel postModel) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
