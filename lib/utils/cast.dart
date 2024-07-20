extension SafeTypeCast on Object? {
  T? asOrNull<T>() {
    var self = this;
    return self is T ? self : null;
  }
}
