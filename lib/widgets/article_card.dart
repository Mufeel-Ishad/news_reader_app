import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/article.dart';
import '../screens/article_detail_screen.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  String _timeAgo(String publishedAt) {
    final published = DateTime.tryParse(publishedAt);
    if (published == null) return '';
    final now = DateTime.now();
    final diff = now.difference(published);

    if (diff.inMinutes < 60) return '${diff.inMinutes} minutes ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    return DateFormat('MMM dd, yyyy').format(published);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticleDetailScreen(article: article),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Hero(
                tag: article.url,
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage ?? '',
                  placeholder: (context, url) =>
                      Container(height: 180, color: Colors.grey.shade300),
                  errorWidget: (context, url, error) => Container(
                    height: 180,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image, size: 48),
                  ),
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Title & Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${article.source.name} • ${_timeAgo(article.publishedAt)}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    article.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
