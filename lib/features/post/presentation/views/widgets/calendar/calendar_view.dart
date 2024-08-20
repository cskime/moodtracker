import 'package:flutter/material.dart';
import 'package:moodtracker/features/post/domain/entities/emotion.dart';
import 'package:moodtracker/features/post/domain/entities/post.dart';
import 'package:moodtracker/features/post/presentation/views/widgets/calendar/calendar_cell.dart';
import 'package:moodtracker/features/post/presentation/views/widgets/calendar/calendar_event_cell.dart';
import 'package:moodtracker/utils/date_range.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.firstDay,
    required this.lastDay,
    required this.posts,
    this.onCalendarCreated,
    this.onDaySelected,
    this.onPageChanged,
  });

  final DateTime focusedDay;
  final DateTime selectedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final List<Post> posts;
  final void Function(PageController controller)? onCalendarCreated;
  final void Function(DateTime selected, DateTime focusedDay)? onDaySelected;
  final void Function(DateTime focusedDay)? onPageChanged;

  Map<Emotion, int> _fractionOfEmotions(Iterable<Post> posts) {
    Map<Emotion, int> result = {};

    for (var post in posts) {
      result.update(
        post.emotion,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }

    return result;
  }

  List<Widget> _dayBackgroundWidgets(Iterable<Post> posts, DateTime day) {
    final fractions = _fractionOfEmotions(posts);
    final sortedEntries = fractions.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    return sortedEntries
        .map<Widget>(
          (entry) => Expanded(
            flex: entry.value,
            child: ColoredBox(color: entry.key.tintColor),
          ),
        )
        .toList();
  }

  Widget? _calendarCellBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
    bool isSelected,
  ) {
    if (posts.isEmpty) {
      return CalendarCell(
        day: day.day,
        isSelected: isSelected,
        isEnabled: false,
      );
    }

    final matchedPosts = posts.where((post) => isSameDay(post.date, day));
    if (matchedPosts.isEmpty) {
      final range = DateRange.fromList(posts.map((post) => post.date).toList());
      return CalendarCell(
        day: day.day,
        isSelected: isSelected,
        isEnabled: range.contains(day),
      );
    }

    return CalendarEventCell(
      flexibleBoxes: _dayBackgroundWidgets(matchedPosts, day),
      day: day.day,
      isSelected: isSelected,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(day, selectedDay);
      },
      firstDay: firstDay,
      lastDay: lastDay,
      headerVisible: false,
      onCalendarCreated: onCalendarCreated,
      onDaySelected: onDaySelected,
      onPageChanged: onPageChanged,
      calendarBuilders: CalendarBuilders(
        todayBuilder: (context, day, focusedDay) => _calendarCellBuilder(
          context,
          day,
          focusedDay,
          false,
        ),
        selectedBuilder: (context, day, focusedDay) {
          return _calendarCellBuilder(
            context,
            day,
            focusedDay,
            true,
          );
        },
        defaultBuilder: (context, day, focusedDay) => _calendarCellBuilder(
          context,
          day,
          focusedDay,
          false,
        ),
      ),
    );
  }
}
