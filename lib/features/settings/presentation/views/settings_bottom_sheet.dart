import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({
    super.key,
    required this.onLogOutPressed,
  });

  final Function() onLogOutPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(FontAwesomeIcons.arrowRightFromBracket),
            title: const Text("Log out"),
            onTap: onLogOutPressed,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
