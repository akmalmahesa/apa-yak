class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverUrl;
  final double rating;
  final int pages;
  final int year;
  final String origin;
  final List<String> genres;
  final List<String> tags;
  int? currentPage;
  bool isSaved;
  bool isCompleted;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverUrl,
    required this.rating,
    required this.pages,
    required this.year,
    required this.origin,
    required this.genres,
    required this.tags,
    this.currentPage,
    this.isSaved = false,
    this.isCompleted = false,
  });

  bool get isReading       => currentPage != null;
  double get progress      => isReading ? currentPage! / pages : 0;
  int get progressPercent  => (progress * 100).round();
}

// ── Badge Model ────────────────────────────────────────────────────────────
class ReadlyBadge {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String category; // e.g., 'Reading', 'Social', 'Milestone'
  final bool isUnlocked;
  final int? unlockedDate; // timestamp
  final String requirement; // How to unlock

  ReadlyBadge({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.category,
    required this.isUnlocked,
    this.unlockedDate,
    required this.requirement,
  });
}