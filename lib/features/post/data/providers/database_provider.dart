import 'package:moodtracker/features/post/domain/entities/post.dart';

abstract class DatabaseProvider {
  Future<void> createPost(Post post);
  Stream<List<Post>> fetchPostsByUserId(String userId);
  Future<void> deletePost(Post post);
}
