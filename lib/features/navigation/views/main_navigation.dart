import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodtracker/features/navigation/models/navigation_tab.dart';
import 'package:moodtracker/features/post/views/calendar_screen.dart';
import 'package:moodtracker/features/post/views/write_screen.dart';

class MainNavigation extends ConsumerStatefulWidget {
  const MainNavigation({
    super.key,
    required this.tab,
  });

  final NavigationTab tab;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainNavigationState();
}

class _MainNavigationState extends ConsumerState<MainNavigation> {
  late int _currentIndex = widget.tab.index;

  void _onItemTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 ? const WriteScreen() : const CalendarScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTap,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.penToSquare),
            label: NavigationTab.write.name,
          ),
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.calendar),
            label: NavigationTab.calendar.name,
          ),
        ],
      ),
    );
  }
}
