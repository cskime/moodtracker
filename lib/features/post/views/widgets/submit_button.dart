import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton({
    super.key,
    required this.title,
    required this.loading,
    this.onPressed,
  });

  final String title;
  final bool loading;
  final void Function()? onPressed;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  var _highlighted = false;

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _highlighted = false;
    });
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _highlighted = true;
    });
  }

  void _onTapCancel() {
    _highlighted = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapUp: _onTapUp,
      onTapDown: _onTapDown,
      onTapCancel: _onTapCancel,
      child: Opacity(
        opacity: _highlighted ? 0.5 : 1,
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: widget.onPressed == null ? Colors.grey : Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: widget.loading
                ? const CircularProgressIndicator.adaptive()
                : Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
