import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import '../models/article.dart';
import '../services/database_service.dart';

class ArticleDetailScreen extends StatefulWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final db = DatabaseService.instance;
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  Future<void> _checkFavorite() async {
    isFavorite = await db.isFavorite(widget.article.url);
    setState(() {});
  }

  Future<void> _toggleFavorite() async {
    if (isFavorite) {
      await db.removeFavorite(widget.article.url);
    } else {
      await db.addFavorite(widget.article);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void _openInBrowser() async {
    final url = Uri.parse(widget.article.url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not launch URL')));
    }
  }

  void _shareArticle() {
    Share.share(widget.article.url);
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: _shareArticle),
          IconButton(
            icon: Icon(isFavorite ? Icons.bookmark : Icons.bookmark_border),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: ListView(
        children: [
          // Hero Image
          Hero(
            tag: article.url,
            child: article.urlToImage != null
                ? Image.network(
                    article.urlToImage!,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 220,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image, size: 60),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  '${article.source.name} • ${article.author ?? "Unknown"}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Text(
                  article.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _openInBrowser,
                  icon: const Icon(Icons.open_in_browser),
                  label: const Text('Read Full Article'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
