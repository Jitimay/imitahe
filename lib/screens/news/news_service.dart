// news_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imitahe3/screens/news/news_articles.dart';

class NewsService {
  final String apiKey = 'dd374f7b8a8d41c0971ab59883ba1263';
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsArticle>> fetchEconomicsNews() async {
    final url = Uri.parse('$baseUrl/everything?q=economics&apiKey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> articlesJson = jsonDecode(response.body)['articles'];
      return articlesJson.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
