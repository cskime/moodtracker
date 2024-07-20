import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/features/authentication/view_models/sign_up_view_model.dart';
import 'package:moodtracker/features/authentication/views/widgets/email_password_form.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const routeName = "signup";
  static const routeUrl = "/signup";

  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  late final SignUpViewModel _viewModel;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _onTap(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void _onSignUpPressed(String email, String password) async {
    try {
      await _viewModel.signUp(email: email, password: password);

      if (mounted) {
        await showAdaptiveDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            title: const Text("Sign up complete!"),
            content: const Text("Go to the sign in page and continue"),
            actions: [
              CupertinoDialogAction(
                child: const Text("Go to sign in"),
                onPressed: () => context.pop(),
              ),
            ],
          ),
        );

        if (mounted) {
          context.pop();
        }
      }
    } catch (e) {
      return;
    }
  }

  void _goToLoginPressed(BuildContext context) {
    context.pop();
  }

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(signUpViewModelProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpViewModelProvider);

    return GestureDetector(
      onTap: () => _onTap(context),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EmailPasswordForm(
                  emailController: emailController,
                  emailValidator: _viewModel.validateEmail,
                  passwordController: passwordController,
                  passwordValidator: _viewModel.validatePassword,
                  submitTitle: "Sign up",
                  onSubmitPressed: state.isLoading ? null : _onSignUpPressed,
                  loading: state.isLoading,
                ),
                if (!state.isLoading && state.hasError)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      state.error!.toString(),
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
    );
  }
}
