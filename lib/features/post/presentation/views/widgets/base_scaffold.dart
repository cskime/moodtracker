import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodtracker/features/settings/presentation/blocs/settings_cubit.dart';
import 'package:moodtracker/features/settings/presentation/views/settings_bottom_sheet.dart';
import 'package:moodtracker/utils/navigator_extension.dart';

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
      builder: (_) => SettingsBottomSheet(
        onLogOutPressed: () => _onLogOutPressed(context),
      ),
      showDragHandle: true,
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }

  void _onLogOutPressed(BuildContext context) async {
    context.read<SettingsCubit>().onLogOutPressed();
    context.pop();
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
