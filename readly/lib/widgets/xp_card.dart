import 'package:flutter/material.dart';
import '../core/theme.dart';

class XpCard extends StatelessWidget {
  final Map<String, dynamic>? xpInfo;

  const XpCard({super.key, required this.xpInfo});

  @override
  Widget build(BuildContext context) {
    final level = xpInfo?['level'] ?? 0;
    final progress = (xpInfo?['progress'] ?? 0).toDouble();
    final totalXP = xpInfo?['totalXP'] ?? 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          /// ICON
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.trending_up,
              color: AppColors.accent,
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          /// LEVEL + PROGRESS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Level $level",
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 6),

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress / 100,
                    minHeight: 6,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation(
                      AppColors.accent,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          /// XP VALUE
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$totalXP",
                style: AppTextStyles.sectionTitle.copyWith(
                  color: AppColors.accent,
                ),
              ),
              Text(
                "Total XP",
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}