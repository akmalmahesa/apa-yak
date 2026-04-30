import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../data/xp_data.dart';

class XpCard extends StatelessWidget {
  const XpCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: XpData.totalXp,
      builder: (context, totalXP, _) {
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
                  color: AppColors.accent.withValues(alpha: 0.2),
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
                      "Level ${XpData.level} • ${XpData.levelName}",
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 6),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: XpData.levelProgress,
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
      },
    );
  }
}
