import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/navigation/models/navigation_tab.dart';
import 'package:moodtracker/features/post/models/emotion.dart';
import 'package:moodtracker/features/post/view_models/write_view_model.dart';
import 'package:moodtracker/features/post/views/widgets/emotion_collection.dart';
import 'package:moodtracker/features/post/views/widgets/emotion_description_input.dart';

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

  var _selectedEmotion = Emotion.normal;

  late final WriteViewModel _viewModel;

  void _onDescriptionChanged(String description) {
    setState(() {});
  }

  void _onPostPressed() async {
    await _viewModel.addPost(
      emotion: _selectedEmotion.key,
      description: _description,
    );
    _description = "";
  }

  void _onEmotionSeleted(Emotion emotion) {
    _selectedEmotion = emotion;
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

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "What's your emotion?",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            EmotionCollection(
              onEmotionSelected: _onEmotionSeleted,
            ),
            const SizedBox(height: 24),
            EmotionDescriptionInput(
              controller: _descriptionEditingController,
              onChanged: _onDescriptionChanged,
            ),
            const Spacer(),
            FilledButton(
              onPressed: canPost ? _onPostPressed : null,
              child: state.isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : const Text("Post"),
            ),
          ],
        ),
      ),
    );
  }
}
