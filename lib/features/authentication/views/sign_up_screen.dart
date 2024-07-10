import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerWidget {
  static const routeName = "signup";
  static const routeUrl = "/signup";

  const SignUpScreen({super.key});

  void _onTap(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void _onSignUpPressed() {}

  void _goToLoginPressed(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TextField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    labelText: "Email",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _onSignUpPressed,
                  child: const Text("Sign up"),
                ),
                TextButton(
                  onPressed: () => _goToLoginPressed(context),
                  child: const Text("Go to Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
