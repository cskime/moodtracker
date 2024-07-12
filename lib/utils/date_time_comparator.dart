DateTime max(DateTime a, DateTime b) => a.compareTo(b) >= 0 ? a : b;

DateTime min(DateTime a, DateTime b) => a.compareTo(b) < 0 ? a : b;
