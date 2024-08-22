import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/authentication/data/repositories/auth_repository.dart';
import 'package:moodtracker/features/authentication/domain/repositories/auth_repository.dart';
import 'package:moodtracker/features/post/data/repositories/post_repository_impl.dart';
import 'package:moodtracker/features/post/domain/entities/emotion.dart';
import 'package:moodtracker/features/post/domain/entities/post.dart';
import 'package:moodtracker/features/post/domain/repositories/post_repository.dart';

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
    required Emotion emotion,
    required String description,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final newPost = Post(
        userId: _authRepository.currentUser.id,
        emotion: emotion,
        description: description,
        date: DateTime.now(),
      );
      await _postRepository.createPost(newPost);
    });
  }
}
