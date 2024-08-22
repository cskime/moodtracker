import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodtracker/features/post/domain/entities/emotion.dart';
import 'package:moodtracker/features/post/presentation/blocs/write/write_cubit.dart';
import 'package:moodtracker/features/post/presentation/views/widgets/base_scaffold.dart';
import 'package:moodtracker/features/post/presentation/views/widgets/write/emotion_collection.dart';
import 'package:moodtracker/features/post/presentation/views/widgets/write/emotion_description_input.dart';
import 'package:moodtracker/features/post/presentation/views/widgets/write/submit_button.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final _descriptionEditingController = TextEditingController();

  void _onTap() {
    FocusScope.of(context).unfocus();
  }

  void _onDescriptionChanged(String description) {
    context.read<WriteCubit>().changeDescription(description);
  }

  void _onEmotionSeleted(Emotion emotion) {
    context.read<WriteCubit>().changeEmotion(emotion);
  }

  void _onPostPressed() async {
    context.read<WriteCubit>().addPost();
    _descriptionEditingController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: BaseScaffold(
        body: BlocBuilder<WriteCubit, WriteState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16)
                  .copyWith(bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "How do you feel now?",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  EmotionCollection(
                    currentEmotion: state.emotion,
                    onEmotionSelected: _onEmotionSeleted,
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: EmotionDescriptionInput(
                      controller: _descriptionEditingController,
                      onChanged: _onDescriptionChanged,
                    ),
                  ),
                  const SizedBox(height: 36),
                  SubmitButton(
                    title: "Save",
                    loading: state.isUploading,
                    onPressed: state.canPost ? _onPostPressed : null,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
