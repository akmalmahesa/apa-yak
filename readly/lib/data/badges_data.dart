import '../core/models.dart';
import 'books_data.dart';

class BadgesData {
  static int get completedBooksCount =>
      allBooks.where((book) => book.isCompleted).length;

  static List<ReadlyBadge> get badges {
    final completed = completedBooksCount;
    final completedPages = allBooks
        .where((book) => book.isCompleted)
        .fold<int>(0, (sum, book) => sum + book.pages);

    return [
      // ── Reading Milestones ────────────────────────────────────
      ReadlyBadge(
        id: 'first_read',
        name: 'Bookworm',
        description: 'Completed your first book',
        icon: '📚',
        category: 'Reading',
        isUnlocked: completed >= 1,
        unlockedDate: completed >= 1
            ? DateTime.now().millisecondsSinceEpoch
            : null,
        requirement: 'Complete 1 book',
      ),
      ReadlyBadge(
        id: 'five_books',
        name: 'Avid Reader',
        description: 'Completed 5 books',
        icon: '📖',
        category: 'Reading',
        isUnlocked: completed >= 5,
        unlockedDate: completed >= 5
            ? DateTime.now().millisecondsSinceEpoch
            : null,
        requirement: 'Complete 5 books',
      ),
      ReadlyBadge(
        id: 'ten_books',
        name: 'Library Enthusiast',
        description: 'Completed 10 books',
        icon: '🏛️',
        category: 'Reading',
        isUnlocked: completed >= 10,
        unlockedDate: completed >= 10
            ? DateTime.now().millisecondsSinceEpoch
            : null,
        requirement: 'Complete 10 books',
      ),
      ReadlyBadge(
        id: 'fifty_books',
        name: 'Literary Legend',
        description: 'Completed 50 books',
        icon: '👑',
        category: 'Reading',
        isUnlocked: completed >= 50,
        unlockedDate: completed >= 50
            ? DateTime.now().millisecondsSinceEpoch
            : null,
        requirement: 'Complete 50 books',
      ),

      // ── Genre Mastery ────────────────────────────────────────
      ReadlyBadge(
        id: 'fantasy_master',
        name: 'Fantasy Enthusiast',
        description: 'Read 5 fantasy books',
        icon: '🧙',
        category: 'Genre',
        isUnlocked: true,
        unlockedDate: DateTime.now().millisecondsSinceEpoch,
        requirement: 'Read 5 fantasy books',
      ),
      ReadlyBadge(
        id: 'mystery_master',
        name: 'Mystery Solver',
        description: 'Read 5 mystery books',
        icon: '🔍',
        category: 'Genre',
        isUnlocked: false,
        requirement: 'Read 5 mystery books',
      ),
      ReadlyBadge(
        id: 'romance_master',
        name: 'Romantic Heart',
        description: 'Read 5 romance books',
        icon: '💕',
        category: 'Genre',
        isUnlocked: false,
        requirement: 'Read 5 romance books',
      ),

      // ── Social Badges ────────────────────────────────────────
      ReadlyBadge(
        id: 'first_review',
        name: 'Critic',
        description: 'Posted your first review',
        icon: '✍️',
        category: 'Social',
        isUnlocked: true,
        unlockedDate: DateTime.now().millisecondsSinceEpoch,
        requirement: 'Post 1 review',
      ),
      ReadlyBadge(
        id: 'ten_reviews',
        name: 'Book Reviewer',
        description: 'Posted 10 reviews',
        icon: '📝',
        category: 'Social',
        isUnlocked: false,
        requirement: 'Post 10 reviews',
      ),
      ReadlyBadge(
        id: 'joined_club',
        name: 'Club Member',
        description: 'Joined your first book club',
        icon: '👥',
        category: 'Social',
        isUnlocked: false,
        requirement: 'Join 1 book club',
      ),

      // ── Streaks & Consistency ────────────────────────────────
      ReadlyBadge(
        id: 'week_streak',
        name: 'Week Warrior',
        description: '7-day reading streak',
        icon: '🔥',
        category: 'Streak',
        isUnlocked: true,
        unlockedDate: DateTime.now().millisecondsSinceEpoch,
        requirement: 'Read for 7 days straight',
      ),
      ReadlyBadge(
        id: 'month_streak',
        name: 'Month Master',
        description: '30-day reading streak',
        icon: '🌟',
        category: 'Streak',
        isUnlocked: false,
        requirement: 'Read for 30 days straight',
      ),

      // ── Time-Based Badges ────────────────────────────────────
      ReadlyBadge(
        id: 'speed_reader',
        name: 'Speed Reader',
        description: 'Read 500+ pages in a month',
        icon: '⚡',
        category: 'Achievement',
        isUnlocked: completedPages >= 500,
        unlockedDate: completedPages >= 500
            ? DateTime.now().millisecondsSinceEpoch
            : null,
        requirement: 'Read 500+ pages in 30 days',
      ),
      ReadlyBadge(
        id: 'night_owl',
        name: 'Night Owl',
        description: 'Read 100 pages after midnight',
        icon: '🦉',
        category: 'Achievement',
        isUnlocked: false,
        requirement: 'Read 100 pages after midnight',
      ),
    ];
  }

  // Grouped badges by category
  static Map<String, List<ReadlyBadge>> get badgesByCategory {
    final Map<String, List<ReadlyBadge>> grouped = {};
    for (var badge in badges) {
      grouped.putIfAbsent(badge.category, () => []);
      grouped[badge.category]!.add(badge);
    }
    return grouped;
  }

  // Get unlocked badges count
  static int get unlockedCount => badges.where((b) => b.isUnlocked).length;

  // Get locked badges count
  static int get lockedCount => badges.where((b) => !b.isUnlocked).length;
}
