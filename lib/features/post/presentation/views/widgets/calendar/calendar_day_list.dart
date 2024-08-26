import 'package:flutter/material.dart';
import 'package:moodtracker/features/post/domain/entities/post.dart';
import 'package:moodtracker/features/post/presentation/views/widgets/calendar/calendar_day_list_edit_button.dart';
import 'package:moodtracker/features/post/presentation/views/widgets/calendar/calendar_day_list_item.dart';

class CalendarDayList extends StatelessWidget {
  const CalendarDayList({
    super.key,
    required this.posts,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.isEditMode,
  });

  final List<Post> posts;
  final void Function() onEditPressed;
  final void Function(Post post) onDeletePressed;
  final bool isEditMode;

  @override
  Widget build(BuildContext context) {
    return posts.isEmpty
        ? Center(
            child: Text(
              "There's no posts.",
              style: TextStyle(color: Colors.grey.shade500),
            ),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "EVENTS",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CalendarDayListEditButton(
                      editing: isEditMode,
                      onPressed: onEditPressed,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return CalendarDayListItem(
                      post: post,
                      editMode: isEditMode,
                      onDeletePressed: () => onDeletePressed(post),
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
