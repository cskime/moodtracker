import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodtracker/features/post/presentation/blocs/calendar/calendar_cubit.dart';
import 'package:moodtracker/features/post/presentation/views/widgets/base_scaffold.dart';
import 'package:moodtracker/features/post/presentation/views/widgets/calendar/calendar_app_bar_title.dart';
import 'package:moodtracker/features/post/presentation/views/widgets/calendar/calendar_day_list.dart';
import 'package:moodtracker/features/post/presentation/views/widgets/calendar/calendar_view.dart';
import 'package:moodtracker/features/post/presentation/utils/date_time_comparator.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late PageController _pageController;

  void _onCalendarCreated(PageController pageController) {
    _pageController = pageController;
  }

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

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CalendarCubit>().state;
    final firstDay = context.read<CalendarCubit>().firstDay;
    final lastDay = DateTime.now();

    return BaseScaffold(
      appBarTitle: CalendarAppBarTitle(
        current: state.focusedDay,
        hasNext: !isSameMonth(state.focusedDay, lastDay),
        hasPrev: !isSameMonth(state.focusedDay, firstDay),
        onLeftPressed: _movePrevMonth,
        onRightPressed: _moveNextMonth,
      ),
      appBarActions: [
        IconButton(
          onPressed: context.read<CalendarCubit>().onTodayPressed,
          icon: const Icon(Icons.today),
        ),
      ],
      body: Column(
        children: [
          CalendarView(
            focusedDay: state.focusedDay,
            selectedDay: state.selectedDay,
            firstDay: firstDay,
            lastDay: lastDay,
            posts: state.posts,
            onCalendarCreated: _onCalendarCreated,
            onDaySelected: context.read<CalendarCubit>().onDaySelected,
            onPageChanged: context.read<CalendarCubit>().onMonthChanged,
          ),
          Expanded(
            child: CalendarDayList(
              posts: state.postsOnDay,
              onEditPressed: context.read<CalendarCubit>().onEditPressed,
              onDeletePressed: context.read<CalendarCubit>().onDeletePressed,
              isEditMode: state.isEditMode,
            ),
          ),
        ],
      ),
    );

    // return state.when(
    //   data: (posts) {},
    //   error: (error, stackTrace) => Center(
    //     child: Text(
    //       error.toString(),
    //     ),
    //   ),
    //   loading: () => const Center(
    //     child: CircularProgressIndicator.adaptive(),
    //   ),
    // );
  }
}
