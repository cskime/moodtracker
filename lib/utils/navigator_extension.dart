import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  Future<T?> push<T>(Route<T> route) {
    return Navigator.of(this).push(route);
  }

  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }
}
