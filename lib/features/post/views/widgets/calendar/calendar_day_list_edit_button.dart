import 'package:flutter/material.dart';

class CalendarDayListEditButton extends StatefulWidget {
  const CalendarDayListEditButton({
    super.key,
    required this.editing,
    required this.onPressed,
  });

  @override
  State<CalendarDayListEditButton> createState() => _EditButtonState();

  final bool editing;
  final void Function() onPressed;
}

class _EditButtonState extends State<CalendarDayListEditButton> {
  var _opacity = 1.0;

  void _setBlur(bool isBlur) => setState(() {
        _opacity = isBlur ? 0.4 : 1.0;
      });

  void _onTapUp(TapUpDetails details) => _setBlur(false);
  void _onTapDown(TapDownDetails details) {
    _setBlur(true);
    // widget.onPressed();
  }

  void _onTapCancel() => _setBlur(false);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _opacity,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 2,
        ),
        child: GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          onTap: widget.onPressed,
          child: Text(
            widget.editing ? "Done" : "Edit",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
