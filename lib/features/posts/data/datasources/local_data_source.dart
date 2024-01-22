import 'dart:convert';

import 'package:clean_architecture_posts_app/core/constants/strings.dart';
import 'package:clean_architecture_posts_app/core/errors/exceptions.dart';
import 'package:clean_architecture_posts_app/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  // get posts from cache memory
  Future<List<PostModel>> getCachedPosts();
  // put posts in cache memory
  Future<Unit> cachePosts(List<PostModel> postModels);
}

class LocalDataSourceImp implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() async {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    // if there is data in cached
    if (jsonString != null) {
      List decodedJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodedJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
