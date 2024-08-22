import 'package:flutter/material.dart';
import 'package:moodtracker/features/post/domain/entities/emotion.dart';

class EmotionCollection extends StatelessWidget {
  const EmotionCollection({
    super.key,
    required this.currentEmotion,
    required this.onEmotionSelected,
  });

  final Emotion currentEmotion;
  final void Function(Emotion emotion) onEmotionSelected;

  void _onEmotionTap(Emotion data) {
    onEmotionSelected(data);
  }

  Color iconColor(Emotion emption) =>
      currentEmotion == emption ? emption.tintColor : Colors.grey.shade300;

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
