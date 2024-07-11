import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  static const routeUrl = "/list";

  const CalendarScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListScreenState();
}

class _ListScreenState extends ConsumerState<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("List"),
    );
  }
}
