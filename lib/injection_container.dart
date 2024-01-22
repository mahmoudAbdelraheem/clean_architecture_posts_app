//! in this file we dealing with dependancy injection over all project
//? using get_it package

import 'package:clean_architecture_posts_app/core/network/internet_info.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/local_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/remote_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/repositories/posts_repository_imp.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/repositories/post_repository.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/add_post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/delete_post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/get_all_posts.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/update_post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - Post

//? BloC
  // factory design pattren (for using object more than one time)
  sl.registerFactory(() => PostsBloc(getAllPostsUseCase: sl.call()));
  sl.registerFactory(
    () => AddUpdateDeletePostBloc(
      addPost: sl.call(),
      deletePost: sl.call(),
      updatePost: sl.call(),
    ),
  );

//? Usecases
  // singleton design pattren (usign object one time)
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostsUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostsUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostsUseCase(sl()));

//? Repository

  sl.registerLazySingleton<PostRepository>(
    () => PostsRepositoryImp(
      remoteDataSource: sl(),
      localDataSource: sl(),
      internetInfo: sl(),
    ),
  );

//? Data Source (Local & remote data) data source
  // remote data source
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImp(client: sl()));

  //local data sourece
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImp(sharedPreferences: sl()));

//! Core

//internet connection
  sl.registerLazySingleton<InternetInfo>(
    () => InternetInfoImp(connectionChecker: sl()),
  );

//! External Package

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
