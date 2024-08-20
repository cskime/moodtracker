import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CalendarAppBarTitle extends StatelessWidget {
  const CalendarAppBarTitle({
    super.key,
    required this.current,
    required this.hasNext,
    required this.hasPrev,
    this.onLeftPressed,
    this.onRightPressed,
  });

  final DateTime current;
  final bool hasNext;
  final bool hasPrev;
  final void Function()? onLeftPressed;
  final void Function()? onRightPressed;

  Color color(bool isEnabled) =>
      isEnabled ? Colors.black : Colors.grey.shade400;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoButton(
          onPressed: hasPrev ? onLeftPressed : null,
          child: Icon(
            FontAwesomeIcons.chevronLeft,
            size: 14,
            color: color(hasPrev),
          ),
        ),
        Text(
          "${current.year}.${current.month}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        CupertinoButton(
          onPressed: hasNext ? onRightPressed : null,
          child: Icon(
            FontAwesomeIcons.chevronRight,
            size: 14,
            color: color(hasNext),
          ),
        ),
      ],
    );
  }
}
