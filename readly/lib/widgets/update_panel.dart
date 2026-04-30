import 'package:flutter/material.dart';
import '../core/theme.dart';

class UpdatePanel extends StatelessWidget {
  final dynamic selectedEntry;
  final double sliderValue;
  final Function(double) setSliderValue;
  final VoidCallback handleUpdate;
  final bool justUpdated;

  const UpdatePanel({
    super.key,
    required this.selectedEntry,
    required this.sliderValue,
    required this.setSliderValue,
    required this.handleUpdate,
    required this.justUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final totalPages = selectedEntry['cr']['totalPages'];
    final currentPercent = ((sliderValue / totalPages) * 100).round();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    selectedEntry['book']['cover'],
                    width: 46,
                    height: 46,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 46,
                      height: 46,
                      color: AppColors.tagBg,
                      child: const Icon(Icons.book, color: AppColors.textMuted, size: 20),
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedEntry['book']['title'],
                        style: AppTextStyles.bookTitle.copyWith(
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Update Progress",
                        style: AppTextStyles.body.copyWith(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.tagBg,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    color: AppColors.textSecondary,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 1,
            color: AppColors.borderColor,
          ),

          /// BODY
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                /// PAGE COUNTS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current page",
                          style: AppTextStyles.body.copyWith(
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          sliderValue.toInt().toString(),
                          style: AppTextStyles.displayTitle.copyWith(
                            fontSize: 54,
                            height: 1,
                          ),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Total pages",
                          style: AppTextStyles.body.copyWith(
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          totalPages.toString(),
                          style: AppTextStyles.sectionTitle.copyWith(
                            fontSize: 42,
                          ),
                        ),
                        Text(
                          "$currentPercent%",
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// BIG PROGRESS BAR
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: sliderValue / totalPages,
                    minHeight: 14,
                    backgroundColor: AppColors.progressBg,
                    valueColor: const AlwaysStoppedAnimation(
                      AppColors.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                /// SLIDER
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 10,
                    activeTrackColor: AppColors.primary,
                    inactiveTrackColor: AppColors.progressBg,
                    thumbColor: AppColors.surface,
                    overlayColor: AppColors.primary.withOpacity(0.1),
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 14,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 20,
                    ),
                  ),
                  child: Slider(
                    min: 0,
                    max: totalPages.toDouble(),
                    value: sliderValue,
                    onChanged: setSliderValue,
                  ),
                ),

                const SizedBox(height: 18),

                /// QUICK BUTTONS
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [25, 50, 75, 100].map((pct) {
                    final pg = ((pct / 100) * totalPages).round();

                    return GestureDetector(
                      onTap: () => setSliderValue(pg.toDouble()),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.tagBg,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          "$pct% ($pg" "p)",
                          style: AppTextStyles.body.copyWith(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 26),

                /// BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton.icon(
                    onPressed: sliderValue ==
                            selectedEntry['cr']['currentPage']
                        ? null
                        : handleUpdate,
                    icon: const Icon(Icons.menu_book_outlined),
                    label: Text(
                      sliderValue >= totalPages
                          ? "Mark as Finished 🎉"
                          : "Update Progress · +10 XP",
                      style: AppTextStyles.label.copyWith(
                        fontSize: 15,
                        color: sliderValue ==
                                selectedEntry['cr']['currentPage']
                            ? AppColors.textMuted
                            : Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: sliderValue ==
                              selectedEntry['cr']['currentPage']
                          ? AppColors.progressBg
                          : AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.progressBg,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
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