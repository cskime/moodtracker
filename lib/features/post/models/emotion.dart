import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Emotion {
  excellent,
  good,
  normal,
  sad,
  annoying,
  bad;

  static Emotion defaultValue = Emotion.excellent;

  String get key => switch (this) {
        Emotion.excellent => "solidFaceLaughBeam",
        Emotion.good => "solidFaceSmile",
        Emotion.normal => "solidFaceMeh",
        Emotion.sad => "solidFaceSadTear",
        Emotion.annoying => "solidFaceTired",
        Emotion.bad => "solidFaceAngry",
      };

  IconData get icon => switch (this) {
        Emotion.excellent => FaceIcon.excellent.iconData,
        Emotion.good => FaceIcon.good.iconData,
        Emotion.normal => FaceIcon.normal.iconData,
        Emotion.sad => FaceIcon.sad.iconData,
        Emotion.annoying => FaceIcon.annoying.iconData,
        Emotion.bad => FaceIcon.bad.iconData,
      };

  Color get tintColor => switch (this) {
        Emotion.excellent => Colors.yellow.shade700,
        Emotion.good => Colors.green.shade700,
        Emotion.normal => Colors.grey.shade700,
        Emotion.sad => Colors.blue.shade700,
        Emotion.annoying => Colors.purple.shade700,
        Emotion.bad => Colors.red.shade700,
      };
}

enum FaceIcon {
  excellent,
  good,
  normal,
  sad,
  annoying,
  bad;

  IconData get iconData => switch (this) {
        FaceIcon.excellent => FontAwesomeIcons.solidFaceLaughBeam,
        FaceIcon.good => FontAwesomeIcons.solidFaceSmile,
        FaceIcon.normal => FontAwesomeIcons.solidFaceMeh,
        FaceIcon.sad => FontAwesomeIcons.solidFaceSadTear,
        FaceIcon.annoying => FontAwesomeIcons.solidFaceTired,
        FaceIcon.bad => FontAwesomeIcons.solidFaceAngry,
      };
}
