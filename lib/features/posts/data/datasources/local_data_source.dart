import 'package:clean_architecture_posts_app/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';

abstract class LocalDataSource {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachePosts(List<PostModel> postModels);
}

class LocalDataSourceImp implements LocalDataSource {
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    // TODO: implement cachePosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    // TODO: implement getCachedPosts
    throw UnimplementedError();
  }
}
