import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/article.dart';
import '../services/news_api_service.dart';
import '../widgets/article_card.dart';
import '../widgets/empty_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final NewsApiService _newsService = NewsApiService();

  List<Article> _results = [];
  List<String> _history = [];
  Timer? _debounce;
  bool _isLoading = false;
  bool _noResults = false;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _search(query);
    });
  }

  Future<void> _search(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _noResults = false;
    });

    try {
      final results = await _newsService.searchArticles(query.trim());
      setState(() {
        _results = results;
        _noResults = results.isEmpty;
      });
      _saveToHistory(query);
    } catch (e) {
      setState(() {
        _results = [];
        _noResults = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _history = prefs.getStringList('search_history') ?? [];
    });
  }

  Future<void> _saveToHistory(String query) async {
    final prefs = await SharedPreferences.getInstance();
    if (_history.contains(query)) return;
    setState(() {
      _history.insert(0, query);
      if (_history.length > 5) _history = _history.sublist(0, 5);
    });
    await prefs.setStringList('search_history', _history);
  }

  Future<void> _clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('search_history');
    setState(() => _history.clear());
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: _controller,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search articles...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                        setState(() => _results.clear());
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),

        // Search history
        if (_results.isEmpty && _history.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Recent Searches",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: _history
                      .map(
                        (h) => ActionChip(
                          label: Text(h),
                          onPressed: () => _search(h),
                        ),
                      )
                      .toList(),
                ),
                TextButton.icon(
                  onPressed: _clearHistory,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text("Clear History"),
                ),
              ],
            ),
          ),

        // Results or loading or empty
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _noResults
              ? const EmptyState(message: "No results found.")
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _results.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ArticleCard(article: _results[index]),
                  ),
                ),
        ),
      ],
    );
  }
}
