import 'package:flutter/material.dart';
import '../core/models.dart';
import '../core/theme.dart';
import '../screens/book_detail_screen.dart';

class ExploreBookTile extends StatelessWidget {
  final Book book;
  final bool showBookmark;
  final double height;

  const ExploreBookTile({
    super.key,
    required this.book,
    this.showBookmark = false,
    this.height = 130,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => BookDetailScreen(book: book)),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              book.coverUrl,
              height: height,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: height,
                color: AppColors.tagBg,
                child: const Icon(Icons.book, color: AppColors.textMuted),
              ),
            ),
          ),
          if (showBookmark)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.bookmark_outline,
                  size: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}