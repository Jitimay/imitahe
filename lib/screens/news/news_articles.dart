// news_article.dart
class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String urlToImage;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] as String,
      description: json['description'] as String? ?? 'No description',
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String? ?? '',
    );
  }
}
