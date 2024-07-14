import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/post/view_models/calendar_view_model.dart';
import 'package:moodtracker/features/post/views/widgets/calendar_app_bar_title.dart';
import 'package:moodtracker/features/post/views/widgets/calendar_day_list.dart';
import 'package:moodtracker/features/post/views/widgets/calendar_view.dart';
import 'package:moodtracker/utils/date_time_comparator.dart' as date_comparator;
import 'package:moodtracker/utils/date_time_comparator.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  static const routeUrl = "/list";

  const CalendarScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late PageController _pageController;
  var _focusedDay = DateTime.now();
  var _selectedDay = DateTime.now();

  void _movePrevMonth() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
    setState(() {});
  }

  void _moveNextMonth() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
    setState(() {});
  }

  void _onTodayPressed() {
    setState(() {
      _focusedDay = DateTime.now();
      _selectedDay = DateTime.now();
    });
  }

  void _onSettingPressed() {}

  void _onCalendarCreated(PageController pageController) {
    _pageController = pageController;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });
  }

  void _onPageChanged(DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(calendarViewModelProvider);

    return state.when(
      data: (posts) {
        final firstDay = posts.fold(
          DateTime.now(),
          (previousValue, element) =>
              date_comparator.min(previousValue, element.date),
        );
        final lastDay = DateTime.now();

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: CalendarAppBarTitle(
              current: _focusedDay,
              hasNext: !isSameMonth(_focusedDay, lastDay),
              hasPrev: !isSameMonth(_focusedDay, firstDay),
              onLeftPressed: _movePrevMonth,
              onRightPressed: _moveNextMonth,
            ),
            actions: [
              IconButton(
                onPressed: _onTodayPressed,
                icon: const Icon(Icons.today),
              ),
              IconButton(
                onPressed: _onSettingPressed,
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          body: Column(
            children: [
              CalendarView(
                focusedDay: _focusedDay,
                selectedDay: _selectedDay,
                firstDay: firstDay,
                lastDay: lastDay,
                posts: posts,
                onCalendarCreated: _onCalendarCreated,
                onDaySelected: _onDaySelected,
                onPageChanged: _onPageChanged,
              ),
              Expanded(
                child: CalendarDayList(
                  posts: posts
                      .where((post) => isSameDay(post.date, _selectedDay))
                      .toList(),
                ),
              ),
            ],
          ),
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
    );
  }
}
