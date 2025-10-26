import 'package:flutter/material.dart';

class CategoryTabs extends StatelessWidget {
  final String selected;
  final Function(String) onChanged;

  const CategoryTabs({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const List<String> categories = [
    'all',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selected == category;

          return ChoiceChip(
            label: Text(category[0].toUpperCase() + category.substring(1)),
            selected: isSelected,
            onSelected: (_) => onChanged(category),
            selectedColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Colors.grey.shade200,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          );
        },
      ),
    );
  }
}
