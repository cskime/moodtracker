class ValidationService {
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Enter an email";
    }

    final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    if (!regExp.hasMatch(email)) {
      return "Email is not valid";
    }

    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Enter a password";
    }

    if (password.length < 8) {
      return "A password should be more than 8 characters.";
    }

    return null;
  }
}
