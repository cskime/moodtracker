import 'package:moodtracker/features/post/domain/entities/post.dart';

abstract class PostRepository {
  Future<void> createPost(Post post);
  Stream<List<Post>> posts({required String userId});
  Future<void> deletePost(Post post);
}
