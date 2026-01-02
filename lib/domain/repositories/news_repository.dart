import 'package:news/core/utils/typedef.dart';
import '../entities/news_article.dart';

abstract class NewsRepository {
  ResultFuture<List<NewsArticle>> getLatestNews({String query = 'India'});
  
  ResultFuture<List<NewsArticle>> getNewsByQuery(String query);
}
