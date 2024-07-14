import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moodtracker/features/post/models/emotion.dart';
import 'package:moodtracker/features/post/models/post.dart';
import 'package:moodtracker/features/post/views/widgets/write/description_box.dart';

class CalendarDayListItem extends StatelessWidget {
  const CalendarDayListItem({
    super.key,
    required this.post,
    required this.editMode,
    required this.onDeletePressed,
  });

  final Post post;
  final bool editMode;
  final void Function() onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final emotion = Emotion.fromKey(post.emotion);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.only(top: 2),
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
          if (editMode)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: onDeletePressed,
                  child: Icon(
                    FontAwesomeIcons.trashCan,
                    color: Colors.red.shade400,
                  ),
                ),
              ],
            ),
          if (!editMode) const SizedBox(width: 16),
        ],
      ),
    );
  }
}
