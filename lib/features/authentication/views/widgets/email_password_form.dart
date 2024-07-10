import 'package:flutter/material.dart';

class EmailPasswordForm extends StatelessWidget {
  const EmailPasswordForm({
    super.key,
    required this.emailController,
    this.emailLabelText = "Email",
    required this.emailValidator,
    required this.passwordController,
    this.passwordLabelText = "Password",
    required this.passwordValidator,
    this.onSubmitPressed,
    required this.submitChild,
  });

  final TextEditingController emailController;
  final String emailLabelText;
  final String? Function(String? email) emailValidator;

  final TextEditingController passwordController;
  final String passwordLabelText;
  final String? Function(String? password) passwordValidator;

  final void Function(String email, String password)? onSubmitPressed;
  final Widget submitChild;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: emailController,
            validator: emailValidator,
            decoration: InputDecoration(
              hintText: emailLabelText,
              labelText: emailLabelText,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
          ),
          TextFormField(
            controller: passwordController,
            validator: passwordValidator,
            obscureText: true,
            decoration: InputDecoration(
              hintText: passwordLabelText,
              labelText: passwordLabelText,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => onSubmitPressed?.call(
              emailController.text,
              passwordController.text,
            ),
            child: submitChild,
          ),
        ],
      ),
    );
  }
}
