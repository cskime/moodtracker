enum NavigationTab {
  write,
  calendar;

  static NavigationTab name(String name) => switch (name) {
        "write" => NavigationTab.write,
        "calendar" => NavigationTab.calendar,
        _ => NavigationTab.write,
      };

  static String get pathParameterString =>
      NavigationTab.values.map((value) => value.name).join("|");
}
