import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/article.dart';
import '../services/news_api_service.dart';
import '../widgets/article_card.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/empty_state.dart';
import '../widgets/category_tabs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsApiService _newsService = NewsApiService();
  List<Article> _articles = [];
  String _selectedCategory = 'all';
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    try {
      final articles = await _newsService.fetchTopHeadlines(
        category: _selectedCategory == 'all' ? null : _selectedCategory,
      );

      setState(() {
        _articles = articles;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    }
  }

  void _onCategorySelected(String category) {
    _selectedCategory = category;
    _fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _fetchArticles,
      child: Column(
        children: [
          CategoryTabs(
            selected: _selectedCategory,
            onChanged: _onCategorySelected,
          ),
          Expanded(
            child: _isLoading
                ? const LoadingShimmer()
                : _isError
                    ? EmptyState(
                        message: "Error fetching news. Please try again.",
                        onRetry: _fetchArticles,
                      )
                    : _articles.isEmpty
                        ? const EmptyState(
                            message: "No articles found.",
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(12),
                            itemCount: _articles.length,
                            itemBuilder: (context, index) {
                              final article = _articles[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: ArticleCard(article: article),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
