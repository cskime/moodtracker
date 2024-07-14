import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DescriptionBox extends StatelessWidget {
  const DescriptionBox({
    super.key,
    required this.child,
    this.date,
  });

  final Widget child;
  final DateTime? date;

  String _timeStringFromDate(BuildContext context, DateTime date) {
    final use24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    final dateFormat = use24HourFormat ? DateFormat.Hm() : DateFormat.jm();
    return dateFormat.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child,
          if (date != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _timeStringFromDate(context, date!),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
