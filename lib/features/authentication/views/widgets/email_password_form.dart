import 'package:flutter/material.dart';
import 'package:moodtracker/features/authentication/views/widgets/custom_text_form_field.dart';
import 'package:moodtracker/features/authentication/views/widgets/form_button.dart';

class EmailPasswordForm extends StatelessWidget {
  const EmailPasswordForm({
    super.key,
    required this.emailController,
    this.emailLabelText = "Email",
    required this.emailValidator,
    required this.passwordController,
    this.passwordLabelText = "Password",
    required this.passwordValidator,
    required this.submitTitle,
    this.onSubmitPressed,
    required this.loading,
  });

  final TextEditingController emailController;
  final String emailLabelText;
  final String? Function(String? email) emailValidator;

  final TextEditingController passwordController;
  final String passwordLabelText;
  final String? Function(String? password) passwordValidator;

  final String submitTitle;
  final void Function(String email, String password)? onSubmitPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(
            controller: emailController,
            validator: emailValidator,
            hintText: emailLabelText,
          ),
          const SizedBox(height: 12),
          CustomTextFormField(
            controller: passwordController,
            validator: passwordValidator,
            hintText: passwordLabelText,
            obscureText: true,
          ),
          const SizedBox(height: 16),
          FormButton(
            title: submitTitle,
            loading: loading,
            onPressed: () => onSubmitPressed?.call(
              emailController.text,
              passwordController.text,
            ),
          ),
        ],
      ),
    );
  }
}
