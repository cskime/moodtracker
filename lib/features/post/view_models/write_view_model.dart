import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/authentication/repositories/auth_repository.dart';
import 'package:moodtracker/features/post/models/post.dart';
import 'package:moodtracker/features/post/repositories/post_repository.dart';

final writeViewModelProvider = AsyncNotifierProvider(WriteViewModel.new);

class WriteViewModel extends AsyncNotifier {
  late final AuthRepository _authRepository;
  late final PostRepository _postRepository;

  @override
  FutureOr build() {
    _authRepository = ref.read(authRepositoryProvider);
    _postRepository = ref.read(postRepositoryProvider);
  }

  Future<void> addPost({
    required String emotion,
    required String description,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final newPost = Post(
        userId: _authRepository.user!.uid,
        emotion: emotion,
        description: description,
        date: DateTime.now(),
      );
      await _postRepository.createPost(newPost);
    });
  }
}