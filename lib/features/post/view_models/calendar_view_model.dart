import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/authentication/repositories/auth_repository.dart';
import 'package:moodtracker/features/post/models/post.dart';
import 'package:moodtracker/features/post/repositories/post_repository.dart';

final calendarViewModelProvider =
    AsyncNotifierProvider<CalendarViewModel, List<Post>>(CalendarViewModel.new);

class CalendarViewModel extends AsyncNotifier<List<Post>> {
  late final AuthRepository _authRepository;
  late final PostRepository _postRepository;

  @override
  FutureOr<List<Post>> build() async {
    _authRepository = ref.read(authRepositoryProvider);
    _postRepository = ref.read(postRepositoryProvider);

    return await _postRepository.fetchPosts(userId: _authRepository.user!.uid);
  }
}
