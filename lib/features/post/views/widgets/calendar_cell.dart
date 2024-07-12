import 'package:flutter/material.dart';

class CalendarCell extends StatelessWidget {
  const CalendarCell({
    super.key,
    required this.day,
    required this.isSelected,
    required this.isEnabled,
  });

  final int day;
  final bool isSelected;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          isSelected ? BoxDecoration(border: Border.all(width: 2)) : null,
      child: Center(
        child: Text(
          "$day",
          style: TextStyle(
            color: isEnabled ? Colors.black : Colors.grey.shade400,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
