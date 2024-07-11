import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/post/view_models/calendar_view_model.dart';

class CalendarScreen extends ConsumerWidget {
  static const routeUrl = "/list";

  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calendarViewModelProvider);

    return Center(
      child: state.when(
        data: (data) {
          return Column(
            children: data
                .map<Widget>(
                  (post) => Text(post.description),
                )
                .toList(),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(
            error.toString(),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
