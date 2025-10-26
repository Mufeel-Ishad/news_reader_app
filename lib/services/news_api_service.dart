import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsApiService {
  static const String API_KEY = 'f7e2396fe42d415a91ebdcf362d3454a';
  static const String BASE_URL = 'https://newsapi.org/v2';

  // Fetch top headlines
  Future<List<Article>> fetchTopHeadlines({
    String country = 'us',
    String? category,
  }) async {
    try {
      var url = '$BASE_URL/top-headlines?country=$country&apiKey=$API_KEY';
      if (category != null && category != 'all') {
        url += '&category=$category';
      }
      final response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = (data['articles'] as List)
            .map((article) => Article.fromJson(article))
            .toList();
        return articles;
      } else if (response.statusCode == 429) {
        throw Exception('API rate limit reached. Please try again later.');
      } else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Search articles
  Future<List<Article>> searchArticles(String query) async {
    try {
      if (query.trim().isEmpty) {
        return [];
      }
      final url = '$BASE_URL/everything?q=$query&apiKey=$API_KEY&pageSize=50';
      final response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = (data['articles'] as List)
            .map((article) => Article.fromJson(article))
            .toList();
        return articles;
      } else {
        throw Exception('Failed to search articles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Search error: $e');
    }
  }

  // Get articles by category
  Future<List<Article>> fetchByCategory(String category) async {
    return fetchTopHeadlines(category: category);
  }
}
