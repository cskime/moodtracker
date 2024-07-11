import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/navigation/models/navigation_tab.dart';
import 'package:moodtracker/features/post/view_models/write_view_model.dart';

class WriteScreen extends ConsumerStatefulWidget {
  static final routeUrl = "/${NavigationTab.write.name}";

  const WriteScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> {
  final _descriptionEditingController = TextEditingController();

  late final WriteViewModel _viewModel;

  void _onPostPressed() async {
    await _viewModel.addPost(
      emotion: "joy",
      description: _descriptionEditingController.text,
    );
    _descriptionEditingController.text = "";
  }

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(writeViewModelProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(writeViewModelProvider);
    final canPost =
        _descriptionEditingController.text.isNotEmpty && !state.isLoading;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "What's your emotion?",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: TextField(
              controller: _descriptionEditingController,
              maxLines: null,
              onChanged: (_) {
                setState(() {});
              },
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
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
    );
  }
}
