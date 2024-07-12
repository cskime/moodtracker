import 'package:flutter/material.dart';

class CalendarEventCell extends StatelessWidget {
  const CalendarEventCell({
    super.key,
    required this.flexibleBoxes,
    required this.day,
    required this.isSelected,
  });

  final List<Widget> flexibleBoxes;
  final int day;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          isSelected ? BoxDecoration(border: Border.all(width: 2)) : null,
      child: Stack(
        children: [
          if (flexibleBoxes.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: flexibleBoxes,
            ),
          const Positioned.fill(
            child: ColoredBox(color: Colors.black12),
          ),
          Center(
            child: Text(
              "$day",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
