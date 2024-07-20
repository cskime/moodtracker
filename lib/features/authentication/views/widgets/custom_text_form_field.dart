import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    this.errorText,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String? Function(String? text) validator;
  final String hintText;
  final String? errorText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        errorText: errorText,
        labelText: hintText,
        labelStyle: TextStyle(color: Colors.grey.shade600),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        filled: true,
        fillColor: Colors.grey.shade100,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
      ),
    );
  }
}
