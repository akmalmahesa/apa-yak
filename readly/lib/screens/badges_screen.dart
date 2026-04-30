import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../data/badges_data.dart';
import '../data/books_data.dart';
import '../widgets/badge_card.dart';

class BadgesScreen extends StatefulWidget {
  const BadgesScreen({super.key});

  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  late String _selectedCategory;
  final categories = [
    'All',
    'Reading',
    'Genre',
    'Social',
    'Streak',
    'Achievement',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = 'All';
  }

  List get _filteredBadges {
    if (_selectedCategory == 'All') {
      return BadgesData.badges;
    }
    return BadgesData.badges
        .where((badge) => badge.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ValueListenableBuilder<int>(
          valueListenable: libraryVersion,
          builder: (context, _, __) => CustomScrollView(
            slivers: [
              // ── Header ────────────────────────────────────────────────
              SliverToBoxAdapter(child: _buildHeader()),

              // ── Stats Section ─────────────────────────────────────────
              SliverToBoxAdapter(child: _buildStatsSection()),

              // ── Category Filter ───────────────────────────────────────
              SliverToBoxAdapter(child: _buildCategoryFilter()),

              // ── Badges Grid ───────────────────────────────────────────
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.65,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final badge = _filteredBadges[index];
                    return BadgeCard(badge: badge);
                  }, childCount: _filteredBadges.length),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Achievements', style: AppTextStyles.sectionTitle),
              const SizedBox(height: 4),
              Text('Unlock badges by reading', style: AppTextStyles.caption),
            ],
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.tagBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: const Icon(
              Icons.emoji_events_outlined,
              color: AppColors.accent,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  // ── Stats Section ───────────────────────────────────────────────────
  Widget _buildStatsSection() {
    final total = BadgesData.badges.length;
    final unlocked = BadgesData.unlockedCount;
    final locked = BadgesData.lockedCount;
    final percentage = ((unlocked / total) * 100).toStringAsFixed(0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Collection Progress',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      fontFamily: 'Georgia',
                    ),
                  ),
                  Text(
                    '$percentage%',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                      fontFamily: 'sans-serif',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Progress bar visual
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: unlocked / total,
                  minHeight: 8,
                  backgroundColor: AppColors.progressBg,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                ),
              ),
              const SizedBox(height: 14),
              // Stats row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(
                    'Total',
                    total.toString(),
                    AppColors.textPrimary,
                  ),
                  _buildStatItem(
                    'Unlocked',
                    unlocked.toString(),
                    AppColors.accent,
                  ),
                  _buildStatItem(
                    'Locked',
                    locked.toString(),
                    AppColors.textMuted,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Stat Item Helper ────────────────────────────────────────────────
  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
            fontFamily: 'sans-serif',
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textMuted,
            fontFamily: 'sans-serif',
          ),
        ),
      ],
    );
  }

  // ── Category Filter ─────────────────────────────────────────────────
  Widget _buildCategoryFilter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter by Category',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              fontFamily: 'Georgia',
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories
                  .map(
                    (category) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: _selectedCategory == category
                                ? AppColors.accent
                                : AppColors.tagBg,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _selectedCategory == category
                                  ? AppColors.accent
                                  : AppColors.borderColor,
                            ),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _selectedCategory == category
                                  ? AppColors.surface
                                  : AppColors.textPrimary,
                              fontFamily: 'sans-serif',
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
