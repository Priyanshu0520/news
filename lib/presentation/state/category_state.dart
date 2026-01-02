import 'package:flutter/material.dart';
import 'package:news/domain/entities/news_article.dart';
import 'package:news/domain/usecases/get_news_by_query.dart';

class CategoryState extends ChangeNotifier {
  final GetNewsByQuery getNewsByQuery;

  CategoryState({
    required this.getNewsByQuery,
  });

  List<NewsArticle> _newsList = [];
  bool _isLoading = true;
  String? _errorMessage;

  List<NewsArticle> get newsList => _newsList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadNewsByCategory(String query) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getNewsByQuery(query);

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (articles) {
        // Filter out articles without images
        _newsList =
            articles.where((article) => article.imageUrl.isNotEmpty).toList();
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
