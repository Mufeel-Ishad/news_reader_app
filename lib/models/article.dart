import 'source.dart';

class Article {
  final String? author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final Source source;
  bool isFavorite;
  int? localId; // For SQLite

  Article({
    this.author,
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.source,
    this.isFavorite = false,
    this.localId,
  });

  // JSON parsing
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      author: json['author'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'] ?? '',
      source: Source.fromJson(json['source'] ?? {}),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'source': source.toJson(),
    };
  }

  // Database methods
  Map<String, dynamic> toDatabase() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'sourceName': source.name,
      'savedAt': DateTime.now().toIso8601String(),
    };
  }

  factory Article.fromDatabase(Map<String, dynamic> db) {
    return Article(
      localId: db['id'],
      author: db['author'],
      title: db['title'],
      description: db['description'],
      url: db['url'],
      urlToImage: db['urlToImage'],
      publishedAt: db['publishedAt'],
      source: Source(name: db['sourceName']),
      isFavorite: true,
    );
  }
}
