import 'package:news/domain/entities/news_article.dart';

class NewsArticleModel extends NewsArticle {
  NewsArticleModel({
    required String articleId,
    required String title,
    required String description,
    required String imageUrl,
    required String url,
    String? content,
    List<String>? creators,
    DateTime? publishedAt,
    String? sourceName,
    String? country,
    List<String>? category,
    String? language,
  }) : super(
          articleId: articleId,
          title: title,
          description: description,
          imageUrl: imageUrl,
          url: url,
          content: content,
          creators: creators,
          publishedAt: publishedAt,
          sourceName: sourceName,
          country: country,
          category: category,
          language: language,
        );

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      articleId: json['article_id'] ?? '',
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      imageUrl: json['image_url'] ?? '',
      url: json['link'] ?? '',
      content: json['content'],
      creators:
          json['creator'] != null ? List<String>.from(json['creator']) : null,
      publishedAt:
          json['pubDate'] != null ? DateTime.tryParse(json['pubDate']) : null,
      sourceName: json['source_name'],
      country: json['country'] != null && (json['country'] as List).isNotEmpty
          ? json['country'][0]
          : null,
      category:
          json['category'] != null ? List<String>.from(json['category']) : null,
      language: json['language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'article_id': articleId,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'link': url,
      'content': content,
      'creator': creators,
      'pubDate': publishedAt?.toIso8601String(),
      'source_name': sourceName,
      'country': country != null ? [country] : null,
      'category': category,
      'language': language,
    };
  }
}
