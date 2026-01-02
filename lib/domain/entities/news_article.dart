class NewsArticle {
  final String articleId;
  final String title;
  final String description;
  final String imageUrl;
  final String url;
  final String? content;
  final List<String>? creators;
  final DateTime? publishedAt;
  final String? sourceName;
  final String? country;
  final List<String>? category;
  final String? language;

  NewsArticle({
    required this.articleId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
    this.content,
    this.creators,
    this.publishedAt,
    this.sourceName,
    this.country,
    this.category,
    this.language,
  });
}
