import 'package:flutter/material.dart';
import '../core/models.dart';
import '../core/theme.dart';

class BadgeCard extends StatelessWidget {
  final ReadlyBadge badge;

  const BadgeCard({super.key, required this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: badge.isUnlocked ? AppColors.surface : AppColors.tagBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: badge.isUnlocked ? AppColors.accent : AppColors.borderColor,
          width: 2,
        ),
        boxShadow: badge.isUnlocked
            ? [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Stack(
        children: [
          // Background gradient effect for unlocked badges
          if (badge.isUnlocked)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.accent.withOpacity(0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon and unlock indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Badge Icon
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: badge.isUnlocked
                            ? AppColors.accent.withOpacity(0.15)
                            : AppColors.borderColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Opacity(
                          opacity: badge.isUnlocked ? 1 : 0.4,
                          child: Text(
                            badge.icon,
                            style: const TextStyle(
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Unlock status
                    if (badge.isUnlocked)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Unlocked',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.surface,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.borderColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Locked',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textMuted,
                            fontFamily: 'sans-serif',
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                // Badge Name
                Text(
                  badge.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: badge.isUnlocked
                        ? AppColors.textPrimary
                        : AppColors.textMuted,
                    fontFamily: 'Georgia',
                  ),
                ),
                const SizedBox(height: 4),
                // Badge Description
                Text(
                  badge.description,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    height: 1.4,
                    fontFamily: 'sans-serif',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                // Requirement info
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: badge.isUnlocked
                        ? AppColors.currentReadingBg
                        : AppColors.progressBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'How to unlock: ${badge.requirement}',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.textMuted,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'sans-serif',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
