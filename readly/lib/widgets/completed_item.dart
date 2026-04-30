import 'package:flutter/material.dart';
import '../core/theme.dart';

class CompletedItem extends StatelessWidget {
  final dynamic book;

  const CompletedItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          /// COVER
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              book['cover'],
              width: 50,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          /// TITLE + AUTHOR
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book['title'],
                  style: AppTextStyles.bookTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  book['author'],
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),

          /// CHECK ICON
          const Icon(
            Icons.check_circle,
            color: AppColors.accent,
          ),
        ],
      ),
    );
  }
}