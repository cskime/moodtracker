import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodtracker/features/authentication/domain/repositories/auth_repository.dart';
import 'package:moodtracker/features/authentication/presentation/blocs/login/login_cubit.dart';
import 'package:moodtracker/features/authentication/presentation/blocs/sign_up/sign_up_cubit.dart';
import 'package:moodtracker/features/authentication/presentation/views/sign_up_screen.dart';
import 'package:moodtracker/features/authentication/presentation/views/widgets/email_password_form.dart';
import 'package:moodtracker/utils/navigator_extension.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "login";
  static const routeUrl = "/login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _onTap() {
    FocusScope.of(context).unfocus();
  }

  void _onLoginPressed(String email, String password) async {
    await context.read<LoginCubit>().login(email: email, password: password);
  }

  void _goToSignUpPressed() {
    context.push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => BlocProvider(
          create: (context) => SignUpCubit(
            authRepository: context.read<AuthRepository>(),
          ),
          child: const SignUpScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Scaffold(
        body: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) => Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  EmailPasswordForm(
                    emailController: emailController,
                    emailErrorText: state.emailErrorMessage,
                    emailValidator: context.read<LoginCubit>().validateEmail,
                    passwordController: passwordController,
                    passwordErrorText: state.passwordErrorMessage,
                    passwordValidator:
                        context.read<LoginCubit>().validatePassword,
                    submitTitle: "Login",
                    onSubmitPressed: state.isLoading ? null : _onLoginPressed,
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
      ),
    );
  }
}
