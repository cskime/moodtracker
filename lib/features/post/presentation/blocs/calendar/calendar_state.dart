part of 'calendar_cubit.dart';

class CalendarState {
  CalendarState({
    this.posts = const [],
    this.postsOnDay = const [],
    DateTime? focusedDay,
    DateTime? selectedDay,
    this.isEditMode = false,
  })  : focusedDay = focusedDay ?? DateTime.now(),
        selectedDay = focusedDay ?? DateTime.now();

  final List<Post> posts;
  final List<Post> postsOnDay;
  final DateTime focusedDay;
  final DateTime selectedDay;
  final bool isEditMode;

  CalendarState copyWith({
    List<Post>? posts,
    List<Post>? postsOnDay,
    DateTime? focusedDay,
    DateTime? selectedDay,
    bool? isEditMode,
  }) {
    return CalendarState(
      posts: posts ?? this.posts,
      postsOnDay: postsOnDay ?? this.postsOnDay,
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}
