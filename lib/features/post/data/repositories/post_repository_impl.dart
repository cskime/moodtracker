import 'package:moodtracker/features/post/data/providers/database_provider.dart';
import 'package:moodtracker/features/post/domain/entities/post.dart';
import 'package:moodtracker/features/post/domain/repositories/post_repository.dart';

class PostRepositoryImpl extends PostRepository {
  PostRepositoryImpl({
    required this.databaseProvider,
  });

  final DatabaseProvider databaseProvider;

  @override
  Future<void> createPost(Post post) async {
    await databaseProvider.createPost(post);
  }

  @override
  Stream<List<Post>> posts({required String userId}) {
    return databaseProvider.fetchPostsByUserId(userId);
  }

  @override
  Future<void> deletePost(Post post) async {
    await databaseProvider.deletePost(post);
  }
}
