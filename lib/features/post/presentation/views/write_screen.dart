import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/app/views/navigation/navigation_tab.dart';
import 'package:moodtracker/features/post/domain/entities/emotion.dart';
import 'package:moodtracker/features/post/presentation/view_models/write_view_model.dart';
import 'package:moodtracker/features/post/presentation/views/widgets/base_scaffold.dart';
import 'package:moodtracker/features/post/presentation/views/widgets/write/emotion_collection.dart';
import 'package:moodtracker/features/post/presentation/views/widgets/write/emotion_description_input.dart';
import 'package:moodtracker/features/post/presentation/views/widgets/write/submit_button.dart';

class WriteScreen extends ConsumerStatefulWidget {
  static final routeUrl = "/${NavigationTab.write.name}";

  const WriteScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> {
  final _descriptionEditingController = TextEditingController();

  String get _description => _descriptionEditingController.text;
  set _description(String newValue) {
    _descriptionEditingController.text = newValue;
  }

  var _currentEmotion = Emotion.defaultValue;

  late final WriteViewModel _viewModel;

  void _onTap() {
    FocusScope.of(context).unfocus();
  }

  void _onDescriptionChanged(String description) {
    setState(() {});
  }

  void _onPostPressed() async {
    await _viewModel.addPost(
      emotion: _currentEmotion,
      description: _description,
    );
    _description = "";
  }

  void _onEmotionSeleted(Emotion emotion) {
    _currentEmotion = emotion;
  }

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(writeViewModelProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(writeViewModelProvider);
    final canPost = _description.isNotEmpty && !state.isLoading;

    return GestureDetector(
      onTap: _onTap,
      child: BaseScaffold(
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
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
                initialValue: _currentEmotion,
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
                loading: state.isLoading,
                onPressed: canPost ? _onPostPressed : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
