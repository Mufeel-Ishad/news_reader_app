import 'package:flutter_test/flutter_test.dart';
import 'package:news_reader_app/services/news_api_service.dart';
import 'package:news_reader_app/models/article.dart';

void main() {
  final NewsApiService api = NewsApiService();

  group('NewsApiService', () {
    test('Fetches top headlines', () async {
      final articles = await api.fetchTopHeadlines();
      expect(articles, isA<List<Article>>());
      expect(articles.length, greaterThan(0));
    });

    test('Search returns results', () async {
      final results = await api.searchArticles('flutter');
      expect(results, isA<List<Article>>());
    });

    test('Empty query returns empty list', () async {
      final results = await api.searchArticles('');
      expect(results, []);
    });

  });
}
