import 'package:flutter/material.dart';
import 'package:moodtracker/features/navigation/navigation_tab.dart';
import 'package:moodtracker/features/post/presentation/views/calendar_screen.dart';
import 'package:moodtracker/features/post/presentation/views/write_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({
    super.key,
    required this.tab,
  });

  final NavigationTab tab;

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  var _currentTab = NavigationTab.write;

  void showScreenAtIndex(int index) {
    setState(() {
      _currentTab = NavigationTab.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (_currentTab) {
        NavigationTab.write => const WriteScreen(),
        NavigationTab.calendar => const CalendarScreen(),
      },
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab.index,
        onTap: showScreenAtIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          ...NavigationTab.values.map<BottomNavigationBarItem>(
            (tab) => BottomNavigationBarItem(
              icon: Icon(tab.icon),
              label: tab.name,
            ),
          ),
        ],
      ),
    );
  }
}
