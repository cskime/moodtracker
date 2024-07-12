import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CalendarAppBarTitle extends StatelessWidget {
  const CalendarAppBarTitle({
    super.key,
    required this.current,
    this.onLeftPressed,
    this.onRightPressed,
  });

  final DateTime current;
  final void Function()? onLeftPressed;
  final void Function()? onRightPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoButton(
          onPressed: onLeftPressed,
          child: const Icon(
            FontAwesomeIcons.chevronLeft,
            size: 14,
            color: Colors.black,
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
          onPressed: onRightPressed,
          child: const Icon(
            FontAwesomeIcons.chevronRight,
            size: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
