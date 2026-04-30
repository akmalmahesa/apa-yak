import 'package:flutter/material.dart';
import '../core/theme.dart';

class ReadingItem extends StatelessWidget {
  final dynamic cr;
  final dynamic book;
  final String? selectedBookId;
  final VoidCallback onTap;

  const ReadingItem({
    super.key,
    required this.cr,
    required this.book,
    required this.selectedBookId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final pct =
        ((cr['currentPage'] / cr['totalPages']) * 100).round();
    final isSelected = selectedBookId == cr['bookId'];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.borderColor,
          ),
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
                errorBuilder: (_, __, ___) => Container(
                  width: 50,
                  height: 70,
                  color: AppColors.tagBg,
                  child: const Icon(Icons.book, color: AppColors.textMuted, size: 28),
                ),
              ),
            ),

            const SizedBox(width: 12),

            /// TEXT AREA
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  Text(
                    book['title'],
                    style: AppTextStyles.bookTitle.copyWith(
                      color: isSelected
                          ? Colors.white
                          : AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 2),

                  /// AUTHOR
                  Text(
                    book['author'],
                    style: AppTextStyles.caption.copyWith(
                      color: isSelected
                          ? Colors.white70
                          : AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// PROGRESS BAR
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: pct / 100,
                      minHeight: 6,
                      backgroundColor: isSelected
                          ? Colors.white24
                          : AppColors.progressBg,
                      valueColor:
                          const AlwaysStoppedAnimation(AppColors.accent),
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// PAGE INFO + PERCENT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${cr['currentPage']} / ${cr['totalPages']} pages",
                        style: AppTextStyles.caption.copyWith(
                          color: isSelected
                              ? Colors.white70
                              : AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        "$pct%",
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? AppColors.accent
                              : AppColors.primary,
                        ),
                      ),
                    ],
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