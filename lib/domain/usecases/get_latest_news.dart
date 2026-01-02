import 'package:news/core/utils/typedef.dart';
import 'package:news/domain/entities/news_article.dart';
import 'package:news/domain/repositories/news_repository.dart';

class GetLatestNews {
  final NewsRepository repository;

  GetLatestNews(this.repository);

  ResultFuture<List<NewsArticle>> call({String query = 'India'}) {
    return repository.getLatestNews(query: query);
  }
}
