import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum NavigationTab {
  write,
  calendar;

  IconData get icon => switch (this) {
        NavigationTab.write => FontAwesomeIcons.penToSquare,
        NavigationTab.calendar => FontAwesomeIcons.calendar,
      };

  String get label => this.name;

  static NavigationTab name(String name) => switch (name) {
        "write" => NavigationTab.write,
        "calendar" => NavigationTab.calendar,
        _ => NavigationTab.write,
      };

  static String get pathParameterString =>
      NavigationTab.values.map((value) => value.name).join("|");
}
