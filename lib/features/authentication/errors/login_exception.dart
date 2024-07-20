class InvalidEmailLoginException implements Exception {
  InvalidEmailLoginException(this.message);
  final String message;
}

class InvalidPasswordLoginException implements Exception {
  InvalidPasswordLoginException(this.message);
  final String message;
}

class LoginException implements Exception {
  LoginException(this.message);
  final String message;
}
