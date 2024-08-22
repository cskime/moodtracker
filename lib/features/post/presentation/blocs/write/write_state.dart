part of 'write_cubit.dart';

class WriteState {
  WriteState({
    required this.emotion,
    required this.description,
    this.isUploading = false,
  });

  WriteState.initial()
      : this(
          emotion: Emotion.defaultValue,
          description: "",
        );

  final Emotion emotion;
  final String description;
  final bool isUploading;

  bool get canPost => description.isNotEmpty && !isUploading;

  WriteState copyWith({
    Emotion? emotion,
    String? description,
    bool? isUploading,
  }) {
    return WriteState(
      emotion: emotion ?? this.emotion,
      description: description ?? this.description,
      isUploading: isUploading ?? this.isUploading,
    );
  }
}
