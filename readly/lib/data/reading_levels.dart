class ReadingLevels {
  static const Map<int, String> names = {
    1: 'Bookmark Starter',
    2: 'Page Hopper',
    3: 'Story Seeker',
    4: 'Chapter Chaser',
    5: 'Shelf Explorer',
    6: 'Plot Diver',
    7: 'Chronicle Sage',
    8: 'Library Keeper',
    9: 'Book Master',
    10: 'Literary Legend',
  };

  static String labelForLevel(int level) {
    if (level <= 1) return names[1]!;
    if (level >= 10) return names[10]!;
    return names[level] ?? names[1]!;
  }
}
