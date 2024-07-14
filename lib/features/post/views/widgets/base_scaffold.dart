import 'package:flutter/material.dart';
import 'package:moodtracker/features/settings/views/settings_bottom_sheet.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    required this.body,
    this.appBarTitle,
    this.appBarActions = const [],
  });

  final Widget body;
  final Widget? appBarTitle;
  final List<Widget> appBarActions;

  void _onSettingPressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const SettingsBottomSheet(),
      showDragHandle: true,
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBarTitle,
        actions: [
          ...appBarActions,
          IconButton(
            onPressed: () => _onSettingPressed(context),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: body,
    );
  }
}
