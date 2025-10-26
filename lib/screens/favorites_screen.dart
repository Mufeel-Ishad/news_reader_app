import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/database_service.dart';
import '../widgets/article_card.dart';
import '../widgets/empty_state.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final db = DatabaseService.instance;
  List<Article> _favorites = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final items = await db.getFavorites();
    setState(() {
      _favorites = items;
      _isLoading = false;
    });
  }

  Future<void> _removeFavorite(String url) async {
    await db.removeFavorite(url);
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_favorites.isEmpty) {
      return const EmptyState(message: "No favorites saved.");
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _favorites.length,
      itemBuilder: (context, index) {
        final article = _favorites[index];

        return Dismissible(
          key: Key(article.url),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) => _removeFavorite(article.url),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ArticleCard(article: article),
          ),
        );
      },
    );
  }
}
