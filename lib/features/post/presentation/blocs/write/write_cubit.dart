import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodtracker/features/authentication/domain/repositories/auth_repository.dart';
import 'package:moodtracker/features/post/domain/entities/emotion.dart';
import 'package:moodtracker/features/post/domain/entities/post.dart';
import 'package:moodtracker/features/post/domain/repositories/post_repository.dart';

part 'write_state.dart';

class WriteCubit extends Cubit<WriteState> {
  WriteCubit({
    required this.authRepository,
    required this.postRepository,
  }) : super(WriteState.initial());

  late final AuthRepository authRepository;
  late final PostRepository postRepository;

  void changeEmotion(Emotion emotion) {
    emit(state.copyWith(emotion: emotion));
  }

  void changeDescription(String description) {
    emit(state.copyWith(description: description));
  }

  Future<void> addPost() async {
    emit(state.copyWith(isUploading: true));

    final newPost = Post(
      userId: authRepository.currentUser.id,
      emotion: state.emotion,
      description: state.description,
      date: DateTime.now(),
    );
    await postRepository.createPost(newPost);

    emit(WriteState.initial());
  }
}
