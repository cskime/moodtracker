import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodtracker/features/authentication/domain/repositories/auth_repository.dart';
import 'package:moodtracker/features/post/domain/entities/post.dart';
import 'package:moodtracker/features/post/domain/repositories/post_repository.dart';
import 'package:moodtracker/features/post/presentation/utils/date_time_comparator.dart' as date_comparator;
import 'package:table_calendar/table_calendar.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit({
    required this.authRepository,
    required this.postRepository,
  }) : super(CalendarState()) {
    final userId = authRepository.currentUser.id;
    final stream = postRepository.posts(userId: userId);
    _subscription = stream.listen(_updatePosts);
  }

  final AuthRepository authRepository;
  final PostRepository postRepository;

  StreamSubscription? _subscription;

  DateTime get firstDay => state.posts.fold(
        DateTime.now(),
        (previousValue, element) => date_comparator.min(
          previousValue,
          element.date,
        ),
      );

  void _updatePosts(List<Post> posts) {
    emit(
      state.copyWith(
        posts: posts,
        postsOnDay: posts
            .where((post) => isSameDay(post.date, state.selectedDay))
            .toList()
          ..sort(
            (a, b) => b.date.compareTo(a.date),
          ),
      ),
    );
  }

  void onMonthChanged(DateTime focusedDay) {
    emit(state.copyWith(focusedDay: focusedDay));
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    emit(state.copyWith(selectedDay: selectedDay));
  }

  void onTodayPressed() {
    emit(
      state.copyWith(
        focusedDay: DateTime.now(),
        selectedDay: DateTime.now(),
      ),
    );
  }

  void onEditPressed() {
    emit(state.copyWith(isEditMode: !state.isEditMode));
  }

  Future<void> onDeletePressed(Post post) async {
    await postRepository.deletePost(post);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
