import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodtracker/features/authentication/presentation/blocs/sign_up/sign_up_cubit.dart';
import 'package:moodtracker/features/authentication/presentation/views/widgets/email_password_form.dart';
import 'package:moodtracker/utils/navigator_extension.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _onTap(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void _onSignUpPressed(String email, String password) async {
    await context.read<SignUpCubit>().signUp(email: email, password: password);

    if (mounted) {
      await showAdaptiveDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
          title: const Text("Sign up complete!"),
          actions: [
            CupertinoDialogAction(
              child: const Text("Continue"),
              onPressed: () => context.pop(),
            ),
          ],
        ),
      );

      if (mounted) {
        context.pop();
      }
    }
  }

  void _goToLoginPressed(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Scaffold(
        body: BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) => Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  EmailPasswordForm(
                    emailController: emailController,
                    emailValidator: context.read<SignUpCubit>().validateEmail,
                    passwordController: passwordController,
                    passwordValidator:
                        context.read<SignUpCubit>().validatePassword,
                    submitTitle: "Sign up",
                    onSubmitPressed: state.isLoading ? null : _onSignUpPressed,
                    loading: state.isLoading,
                  ),
                  if (!state.isLoading && state.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        state.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  TextButton(
                    onPressed: () => _goToLoginPressed(context),
                    child: const Text(
                      "Go to Login",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
