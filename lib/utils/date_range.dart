import 'package:moodtracker/utils/date_time_comparator.dart';

class DateRange {
  DateRange(this.lowerbound, this.upperbound);

  DateRange.fromList(List<DateTime> dates)
      : upperbound = dates.reduce(max),
        lowerbound = dates.reduce(min);

  final DateTime lowerbound;
  final DateTime upperbound;

  bool contains(DateTime date) =>
      date.compareTo(lowerbound) >= 0 && date.compareTo(upperbound) <= 0;

  @override
  String toString() {
    return "[$lowerbound - $upperbound]";
  }
}
