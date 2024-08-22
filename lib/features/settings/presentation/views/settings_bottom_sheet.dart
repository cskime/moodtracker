import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodtracker/features/settings/presentation/view_models/settings_view_model.dart';

class SettingsBottomSheet extends ConsumerWidget {
  const SettingsBottomSheet({super.key});

  void _onLogOutTap(BuildContext context, WidgetRef ref) async {
    ref.read(settingsViewModelProvider.notifier).logOut();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(FontAwesomeIcons.arrowRightFromBracket),
            title: const Text("Log out"),
            onTap: () => _onLogOutTap(context, ref),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
