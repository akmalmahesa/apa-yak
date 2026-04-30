import 'package:flutter/material.dart';
import 'package:readly/screens/reading_tracker.dart';
import 'screens/home_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/badges_screen.dart';
import 'screens/profile_screen.dart';
import 'widgets/bottom_nav.dart';

class AppNavigator extends StatefulWidget {
  const AppNavigator({super.key});

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  int _index = 0;

  // Only Home and Explore are implemented.
  // Others show a placeholder until built out.
  static const _pages = <Widget>[
    HomeScreen(),
    ExploreScreen(),
    ReadingTrackerPage(),
    BadgesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: ReadlyBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
