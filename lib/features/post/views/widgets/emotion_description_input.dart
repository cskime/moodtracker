import 'package:flutter/material.dart';
import 'package:moodtracker/features/post/views/widgets/description_box.dart';

class EmotionDescriptionInput extends StatefulWidget {
  const EmotionDescriptionInput({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final void Function(String description) onChanged;

  @override
  State<EmotionDescriptionInput> createState() =>
      _EmotionDescriptionInputState();
}

class _EmotionDescriptionInputState extends State<EmotionDescriptionInput> {
  late final FocusNode _focusNode;

  void _onTap() => _focusNode.requestFocus();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: DescriptionBox(
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          maxLines: null,
          onChanged: widget.onChanged,
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
      ),
    );
  }
}
