import 'package:news/core/utils/typedef.dart';
import 'package:news/domain/entities/news_article.dart';
import 'package:news/domain/repositories/news_repository.dart';

class GetNewsByQuery {
  final NewsRepository repository;

  GetNewsByQuery(this.repository);

  ResultFuture<List<NewsArticle>> call(String query) async {
    return await repository.getNewsByQuery(query);
  }
}
