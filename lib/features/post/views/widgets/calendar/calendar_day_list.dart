import 'package:flutter/material.dart';
import 'package:moodtracker/features/post/models/emotion.dart';
import 'package:moodtracker/features/post/models/post.dart';
import 'package:moodtracker/features/post/views/widgets/calendar/calendar_day_list_edit_button.dart';
import 'package:moodtracker/features/post/views/widgets/calendar/calendar_day_list_item.dart';

class CalendarDayList extends StatefulWidget {
  const CalendarDayList({
    super.key,
    required this.posts,
    required this.onDeletePressed,
  });

  final List<Post> posts;
  final void Function(Post post) onDeletePressed;

  @override
  State<CalendarDayList> createState() => _CalendarDayListState();
}

class _CalendarDayListState extends State<CalendarDayList> {
  bool _editMode = false;

  void _onEditPressed() => setState(() {
        _editMode = !_editMode;
      });

  @override
  Widget build(BuildContext context) {
    final validPosts = widget.posts
        .where(
          (post) => Emotion.fromKey(post.emotion) != null,
        )
        .toList()
      ..sort(
        (a, b) => b.date.compareTo(a.date),
      );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CalendarDayListEditButton(
              editing: _editMode,
              onPressed: _onEditPressed,
            ),
            const SizedBox(width: 24),
          ],
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: validPosts.length,
            itemBuilder: (context, index) {
              final post = validPosts[index];
              return CalendarDayListItem(
                post: post,
                editMode: _editMode,
                onDeletePressed: () => widget.onDeletePressed(post),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
          ),
        ),
      ],
    );
  }
}
