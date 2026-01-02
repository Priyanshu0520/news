import 'package:dartz/dartz.dart';
import 'package:news/core/error/failures.dart';
import 'package:news/core/utils/typedef.dart';
import 'package:news/data/datasources/news_remote_datasource.dart';
import 'package:news/domain/entities/news_article.dart';
import 'package:news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<List<NewsArticle>> getLatestNews({String query = 'India'}) async {
    try {
      final result = await remoteDataSource.getLatestNews(query: query);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<List<NewsArticle>> getNewsByQuery(String query) async {
    try {
      final result = await remoteDataSource.getNewsByQuery(query);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
