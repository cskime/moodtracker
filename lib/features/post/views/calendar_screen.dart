import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/post/view_models/calendar_view_model.dart';
import 'package:moodtracker/features/post/views/widgets/calendar_app_bar_title.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  static const routeUrl = "/list";

  const CalendarScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late PageController _pageController;
  final _focusedDay = DateTime.now();
  var _selectedDay = DateTime.now();

  void _movePrevMonth() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _moveNextMonth() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _onTodayPressed() {
    setState(() {
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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(calendarViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CalendarAppBarTitle(
          current: _focusedDay,
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
      body: SingleChildScrollView(
        child: Center(
          child: state.when(
            data: (data) => Column(
              children: [
                TableCalendar(
                  focusedDay: _selectedDay,
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                  firstDay: data.fold(
                    DateTime.now(),
                    (previousValue, element) =>
                        previousValue.compareTo(element.date) > 0
                            ? element.date
                            : previousValue,
                  ),
                  lastDay: DateTime.now(),
                  headerVisible: false,
                  eventLoader: (day) =>
                      data.where((post) => isSameDay(day, post.date)).toList(),
                  onCalendarCreated: _onCalendarCreated,
                  onDaySelected: _onDaySelected,
                ),
                ...data
                    .where((post) => isSameDay(post.date, _selectedDay))
                    .map<Widget>((post) => Text(post.description)),
              ],
            ),
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
      ),
    );
  }
}
