import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/features/authentication/views/sign_up_screen.dart';

class LoginScreen extends ConsumerWidget {
  static const routeName = "login";
  static const routeUrl = "/login";

  const LoginScreen({super.key});

  void _onTap(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void _onLoginPressed() {}

  void _goToSignUpPressed(BuildContext context) {
    context.pushNamed(SignUpScreen.routeName);
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
                  onPressed: _onLoginPressed,
                  child: const Text("Login"),
                ),
                TextButton(
                  onPressed: () => _goToSignUpPressed(context),
                  child: const Text("Go to Sign up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
