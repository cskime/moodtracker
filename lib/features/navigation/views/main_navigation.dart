import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/navigation/models/navigation_tab.dart';
import 'package:moodtracker/features/navigation/view_models/main_navigation_view_model.dart';
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
  late final viewModelProvider = mainNavigationViewModelProvider(widget.tab);

  @override
  Widget build(BuildContext context) {
    final currentTab = ref.watch(viewModelProvider);

    return Scaffold(
      body: switch (currentTab) {
        NavigationTab.write => const WriteScreen(),
        NavigationTab.calendar => const CalendarScreen(),
      },
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab.index,
        onTap: ref.read(viewModelProvider.notifier).showScreenAtIndex,
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
