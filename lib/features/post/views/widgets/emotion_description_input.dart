import 'package:flutter/material.dart';

class EmotionDescriptionInput extends StatelessWidget {
  const EmotionDescriptionInput({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final void Function(String description) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2,
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        onChanged: onChanged,
        cursorColor: Colors.black,
        cursorHeight: 16,
        style: const TextStyle(fontSize: 16),
        decoration: const InputDecoration(
          hintText: "Tell me about your emotion...",
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
