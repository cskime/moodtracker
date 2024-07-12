import 'package:flutter/material.dart';
import 'package:moodtracker/features/post/models/emotion.dart';
import 'package:moodtracker/features/post/models/post.dart';
import 'package:moodtracker/features/post/views/widgets/description_box.dart';

class CalendarDayList extends StatelessWidget {
  const CalendarDayList({
    super.key,
    required this.posts,
  });

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    final validPosts = posts
        .where(
          (post) => Emotion.fromKey(post.emotion) != null,
        )
        .toList()
      ..sort(
        (a, b) => b.date.compareTo(a.date),
      );

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: validPosts.length,
      itemBuilder: (context, index) {
        final post = validPosts[index];
        final emotion = Emotion.fromKey(post.emotion);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(
                emotion!.icon,
                color: emotion.tintColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DescriptionBox(
                date: post.date,
                child: Text(post.description),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 16,
      ),
    );
  }
}
