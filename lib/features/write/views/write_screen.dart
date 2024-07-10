import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/navigation/models/navigation_tab.dart';

class WriteScreen extends ConsumerStatefulWidget {
  static final routeUrl = "/${NavigationTab.write.name}";

  const WriteScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Write"),
    );
  }
}
