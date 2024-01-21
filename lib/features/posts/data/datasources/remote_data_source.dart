import 'dart:convert';

import 'package:clean_architecture_posts_app/core/constants/strings.dart';
import 'package:clean_architecture_posts_app/core/errors/exceptions.dart';
import 'package:clean_architecture_posts_app/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int id);

  Future<Unit> updatePost(PostModel postModel);

  Future<Unit> addPost(PostModel postModel);
}

class RemoteDataSourceImp implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImp({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    var response =
        await client.get(Uri.parse('${baseUrl}posts'), headers: myHeaders);
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((postModelJson) => PostModel.fromJson(postModelJson))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final Map<String, dynamic> body = {
      'title': postModel.title,
      'bodt': postModel.body,
    };

    var response = await client.post(Uri.parse('${baseUrl}posts'), body: body);
    //post is added
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    var response = await client.delete(
        Uri.parse('${baseUrl}posts/${id.toString()}'),
        headers: myHeaders);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final String postId = postModel.id.toString();
    final Map<String, dynamic> body = {
      'title': postModel.title,
      'body': postModel.body,
    };
    var response =
        await client.patch(Uri.parse('${baseUrl}posts/$postId'), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
