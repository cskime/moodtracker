import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/navigation/models/navigation_tab.dart';

final mainNavigationViewModelProvider = NotifierProvider.family<
    MainNavigationViewModel,
    NavigationTab,
    NavigationTab>(MainNavigationViewModel.new);

class MainNavigationViewModel
    extends FamilyNotifier<NavigationTab, NavigationTab> {
  @override
  NavigationTab build(NavigationTab arg) => arg;

  void showScreenAtIndex(int index) {
    const tabs = NavigationTab.values;
    if (index >= tabs.length) {
      return;
    }
    state = tabs[index];
  }
}
