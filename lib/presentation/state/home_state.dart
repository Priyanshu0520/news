import 'package:flutter/material.dart';
import 'package:news/domain/entities/news_article.dart';
import 'package:news/domain/usecases/get_latest_news.dart';
import 'package:news/domain/usecases/get_news_by_query.dart';
import 'package:news/core/constants/api_constants.dart';

class HomeState extends ChangeNotifier {
  final GetLatestNews getLatestNews;
  final GetNewsByQuery getNewsByQuery;

  HomeState({
    required this.getLatestNews,
    required this.getNewsByQuery,
  });

  // Section-wise news storage
  final Map<String, List<NewsArticle>> _sectionNews = {};
  final Map<String, bool> _sectionLoading = {};
  final Map<String, String?> _sectionErrors = {};

  bool _isInitializing = true;

  Map<String, List<NewsArticle>> get sectionNews => _sectionNews;
  Map<String, bool> get sectionLoading => _sectionLoading;
  Map<String, String?> get sectionErrors => _sectionErrors;
  bool get isInitializing => _isInitializing;

  List<NewsArticle> getNewsForSection(String sectionTitle) {
    return _sectionNews[sectionTitle] ?? [];
  }

  bool isLoadingSection(String sectionTitle) {
    return _sectionLoading[sectionTitle] ?? false;
  }

  String? getErrorForSection(String sectionTitle) {
    return _sectionErrors[sectionTitle];
  }

  Future<void> initialize() async {
    _isInitializing = true;
    notifyListeners();

    // Load all sections in parallel
    final futures = ApiConstants.indiaCategories.map((category) {
      return loadSectionNews(category['title']!, category['query']!);
    }).toList();

    await Future.wait(futures);

    _isInitializing = false;
    notifyListeners();
  }

  Future<void> loadSectionNews(String sectionTitle, String query) async {
    _sectionLoading[sectionTitle] = true;
    _sectionErrors[sectionTitle] = null;
    notifyListeners();

    final result = await getNewsByQuery(query);

    result.fold(
      (failure) {
        _sectionErrors[sectionTitle] = failure.message;
        _sectionLoading[sectionTitle] = false;
        _sectionNews[sectionTitle] = [];
        notifyListeners();
      },
      (articles) {
        // Filter out articles without images
        final articlesWithImages = articles
            .where((article) => article.imageUrl.isNotEmpty)
            .take(10)
            .toList();
        _sectionNews[sectionTitle] = articlesWithImages;
        _sectionLoading[sectionTitle] = false;
        notifyListeners();
      },
    );
  }

  Future<void> refreshSection(String sectionTitle, String query) async {
    await loadSectionNews(sectionTitle, query);
  }
}
