DateTime max(DateTime a, DateTime b) => a.compareTo(b) >= 0 ? a : b;

DateTime min(DateTime a, DateTime b) => a.compareTo(b) < 0 ? a : b;

extension DateTimeComparator on DateTime {
  bool operator >(DateTime other) => compareTo(other) == 1;
  bool operator <(DateTime other) => compareTo(other) == -1;
}
