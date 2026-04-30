import 'package:flutter/material.dart';
import '../widgets/xp_card.dart';
import '../widgets/reading_item.dart';
import '../widgets/update_panel.dart';
import '../widgets/completed_item.dart';
import '../data/books_data.dart';
import '../core/models.dart';
import '../core/theme.dart';

class ReadingTrackerPage extends StatefulWidget {
  const ReadingTrackerPage({super.key});

  @override
  State<ReadingTrackerPage> createState() => _ReadingTrackerPageState();
}

class _ReadingTrackerPageState extends State<ReadingTrackerPage> {
  String? selectedBookId;
  double sliderValue = 0;
  bool justUpdated = false;

  Map<String, dynamic>? xpInfo;

  @override
  void initState() {
    super.initState();

    xpInfo = {
      'level': 7,
      'progress': 60,
      'totalXP': 2400,
    };
  }

  List<Book> get readingList =>
      allBooks.where((b) => !b.isCompleted && b.currentPage != null).toList();

  List<Book> get readBooks =>
      allBooks.where((b) => b.isCompleted).toList();

  Book? get selectedEntry {
    try {
      return readingList.firstWhere((b) => b.id == selectedBookId);
    } catch (e) {
      return null;
    }
  }

  void openBook(String bookId, double currentPage) {
    setState(() {
      selectedBookId = bookId;
      sliderValue = currentPage;
      justUpdated = false;
    });
  }

  void handleUpdate() {
    if (selectedBookId == null) return;

    setState(() {
      justUpdated = true;

      final book = allBooks.firstWhere((b) => b.id == selectedBookId);

      book.currentPage = sliderValue.toInt();

      if (book.currentPage == book.pages) {
        book.isCompleted = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final book = selectedEntry;

    return Scaffold(
      backgroundColor: AppColors.background, // ✅ pakai theme
      body: SafeArea(
        child: ListView(
          children: [
            /// HEADER
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reading Tracker",
                    style: AppTextStyles.displayTitle, // ✅ theme
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Track your progress, earn XP with every update",
                    style: AppTextStyles.body,
                  ),
                ],
              ),
            ),

            /// XP CARD
            XpCard(xpInfo: xpInfo),

            /// CURRENTLY READING
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Currently Reading",
                style: AppTextStyles.sectionTitle, // ✅ theme
              ),
            ),

            const SizedBox(height: 10),

            /// LIST READING
            if (readingList.isEmpty)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "No books in progress",
                  style: AppTextStyles.body,
                ),
              )
            else
              Column(
                children: readingList.map((book) {
                  return ReadingItem(
                    cr: {
                      'bookId': book.id,
                      'currentPage': book.currentPage ?? 0,
                      'totalPages': book.pages,
                    },
                    book: {
                      'title': book.title,
                      'author': book.author,
                      'cover': book.coverUrl,
                    },
                    selectedBookId: selectedBookId,
                    onTap: () => openBook(
                      book.id,
                      (book.currentPage ?? 0).toDouble(),
                    ),
                  );
                }).toList(),
              ),

            /// UPDATE PANEL
            if (book != null)
              UpdatePanel(
                selectedEntry: {
                  'cr': {
                    'totalPages': book.pages,
                  },
                  'book': {
                    'title': book.title,
                    'cover': book.coverUrl,
                  }
                },
                sliderValue: sliderValue,
                setSliderValue: (v) {
                  setState(() => sliderValue = v);
                },
                handleUpdate: handleUpdate,
                justUpdated: justUpdated,
              ),

            /// COMPLETED SECTION
            if (readBooks.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Completed (${readBooks.length})",
                      style: AppTextStyles.sectionTitle, // ✅ theme
                    ),
                    const SizedBox(height: 10),

                    ...readBooks.map((book) {
                      return CompletedItem(
                        book: {
                          'title': book.title,
                          'author': book.author,
                          'cover': book.coverUrl,
                        },
                      );
                    }).toList(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}