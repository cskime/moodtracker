import 'package:flutter/material.dart';
import 'package:moodtracker/features/post/models/emotion.dart';

class EmotionCollection extends StatefulWidget {
  const EmotionCollection({
    super.key,
    required this.initialValue,
    required this.onEmotionSelected,
  });

  final Emotion initialValue;
  final void Function(Emotion emotion) onEmotionSelected;

  @override
  State<EmotionCollection> createState() => _EmotionCollectionState();
}

class _EmotionCollectionState extends State<EmotionCollection> {
  late var _currentData = widget.initialValue;

  void _onEmotionTap(Emotion data) {
    widget.onEmotionSelected(data);
    setState(() {
      _currentData = data;
    });
  }

  Color iconColor(Emotion emption) =>
      _currentData == emption ? emption.tintColor : Colors.grey.shade300;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Wrap(
        spacing: 12,
        children: [
          ...Emotion.values.map<Widget>(
            (emotion) => GestureDetector(
              onTap: () => _onEmotionTap(emotion),
              child: Icon(
                emotion.icon,
                color: iconColor(emotion),
                size: 32,
              ),
            ),
          )
        ],
      ),
    );
  }
}
