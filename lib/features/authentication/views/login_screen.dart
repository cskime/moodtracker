import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/features/authentication/errors/login_exception.dart';
import 'package:moodtracker/features/authentication/view_models/login_view_model.dart';
import 'package:moodtracker/features/authentication/views/sign_up_screen.dart';
import 'package:moodtracker/features/authentication/views/widgets/email_password_form.dart';
import 'package:moodtracker/features/post/views/write_screen.dart';
import 'package:moodtracker/utils/cast.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "login";
  static const routeUrl = "/login";

  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final LoginViewModel _viewModel;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _onTap() {
    FocusScope.of(context).unfocus();
  }

  void _onLoginPressed(String email, String password) async {
    final succeed = await _viewModel.login(email: email, password: password);
    if (succeed && mounted) {
      context.go(WriteScreen.routeUrl);
    }
  }

  void _goToSignUpPressed() {
    context.pushNamed(SignUpScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(loginViewModelProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginViewModelProvider);

    return GestureDetector(
      onTap: _onTap,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EmailPasswordForm(
                  emailController: emailController,
                  emailErrorText: state.error
                      ?.asOrNull<InvalidEmailLoginException>()
                      ?.message,
                  emailValidator: _viewModel.validateEmail,
                  passwordController: passwordController,
                  passwordErrorText: state.error
                      ?.asOrNull<InvalidPasswordLoginException>()
                      ?.message,
                  passwordValidator: _viewModel.validatePassword,
                  submitTitle: "Login",
                  onSubmitPressed: state.isLoading ? null : _onLoginPressed,
                  loading: state.isLoading,
                ),
                if (!state.isLoading && state.error is LoginException)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      state.error?.asOrNull<LoginException>()?.message ??
                          "Unknown Error",
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                TextButton(
                  onPressed: _goToSignUpPressed,
                  child: const Text(
                    "Go to Sign up",
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
