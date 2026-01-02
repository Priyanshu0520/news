import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:news/data/datasources/news_remote_datasource.dart';
import 'package:news/data/repositories/news_repository_impl.dart';
import 'package:news/domain/repositories/news_repository.dart';
import 'package:news/domain/usecases/get_latest_news.dart';
import 'package:news/domain/usecases/get_news_by_query.dart';
import 'package:news/presentation/state/category_state.dart';
import 'package:news/presentation/state/home_state.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Presentation (State Management)
  sl.registerFactory(() => HomeState(
        getLatestNews: sl(),
        getNewsByQuery: sl(),
      ));

  sl.registerFactory(() => CategoryState(
        getNewsByQuery: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton(() => GetLatestNews(sl()));
  sl.registerLazySingleton(() => GetNewsByQuery(sl()));

  // Repository
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(client: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}
