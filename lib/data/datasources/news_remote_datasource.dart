import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/core/constants/api_constants.dart';
import 'package:news/data/models/news_article_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsArticleModel>> getLatestNews({String query = 'India'});
  
  Future<List<NewsArticleModel>> getNewsByQuery(String query);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NewsArticleModel>> getLatestNews({String query = 'India'}) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.latest}?apikey=${ApiConstants.apiKey}&q=$query&country=${ApiConstants.countryIndia}&language=en',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      if (data['status'] == 'success' && data['results'] != null) {
        final articles = data['results'] as List;
        return articles
            .map((article) => NewsArticleModel.fromJson(article))
            .where((article) => article.imageUrl.isNotEmpty)
            .toList();
      } else {
        throw Exception('No articles found');
      }
    } else {
      throw Exception('Failed to load news: ${response.statusCode}');
    }
  }

  @override
  Future<List<NewsArticleModel>> getNewsByQuery(String query) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.latest}?apikey=${ApiConstants.apiKey}&q=$query&country=${ApiConstants.countryIndia}&language=en',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      if (data['status'] == 'success' && data['results'] != null) {
        final articles = data['results'] as List;
        return articles
            .map((article) => NewsArticleModel.fromJson(article))
            .where((article) => article.imageUrl.isNotEmpty)
            .toList();
      } else {
        throw Exception('No articles found');
      }
    } else {
      throw Exception('Failed to load news: ${response.statusCode}');
    }
  }
}
