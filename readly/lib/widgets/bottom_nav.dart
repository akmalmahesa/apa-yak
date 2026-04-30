import 'package:flutter/material.dart';
import '../core/theme.dart';

class ReadlyBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const ReadlyBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    (Icons.home_outlined,    Icons.home,         'HOME'),
    (Icons.explore_outlined, Icons.explore,      'EXPLORE'),
    (Icons.menu_book_outlined,Icons.menu_book,   'LIBRARY'),
    (Icons.emoji_events_outlined,Icons.emoji_events,'BADGES'),
    (Icons.person_outline,   Icons.person,       'PROFILE'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _items.length,
              (i) => _NavItem(
                outlinedIcon: _items[i].$1,
                filledIcon:   _items[i].$2,
                label:        _items[i].$3,
                isActive:     currentIndex == i,
                onTap:        () => onTap(i),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData outlinedIcon;
  final IconData filledIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.outlinedIcon,
    required this.filledIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? filledIcon : outlinedIcon,
            color: isActive ? AppColors.primary : AppColors.textMuted,
            size: 22,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontFamily: 'sans-serif',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: isActive ? AppColors.primary : AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 2),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 2,
            width: isActive ? 20 : 0,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }
}