import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/authentication/data/repositories/auth_repository.dart';
import 'package:moodtracker/features/authentication/domain/repositories/auth_repository.dart';
import 'package:moodtracker/features/post/data/repositories/post_repository_impl.dart';
import 'package:moodtracker/features/post/domain/entities/post.dart';
import 'package:moodtracker/features/post/domain/repositories/post_repository.dart';

final calendarViewModelProvider =
    StreamNotifierProvider<CalendarViewModel, List<Post>>(
        CalendarViewModel.new);

class CalendarViewModel extends StreamNotifier<List<Post>> {
  late final AuthRepository _authRepository;
  late final PostRepository _postRepository;

  @override
  Stream<List<Post>> build() {
    _authRepository = ref.read(authRepositoryProvider);
    _postRepository = ref.read(postRepositoryProvider);

    return _postRepository.fetchPosts(userId: _authRepository.currentUser.id);
  }

  Future<void> deletePost(Post post) async {
    await _postRepository.deletePost(post);
  }
}
