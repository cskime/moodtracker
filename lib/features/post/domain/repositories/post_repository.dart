import 'package:moodtracker/features/post/domain/entities/post.dart';

abstract class PostRepository {
  Future<void> createPost(Post post);
  Stream<List<Post>> fetchPosts({required String userId});
  Future<void> deletePost(Post post);
}
