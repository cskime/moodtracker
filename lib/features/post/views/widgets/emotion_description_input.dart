import 'package:flutter/material.dart';
import 'package:moodtracker/features/post/views/widgets/description_box.dart';

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
    return DescriptionBox(
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
