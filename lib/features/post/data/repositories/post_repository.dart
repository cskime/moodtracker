import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/post/domain/entities/post.dart';

final postRepositoryProvider = Provider((ref) => PostRepository());

class PostRepository {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  CollectionReference<Post> _collection({required String userId}) => _database
      .collection("users")
      .doc(userId)
      .collection("posts")
      .withConverter<Post>(
        fromFirestore: Post.fromFirestore,
        toFirestore: (value, options) => value.toFirestore(),
      );

  Future<void> createPost(Post post) async {
    final document = await _collection(userId: post.userId).add(post);
    await _collection(userId: post.userId)
        .doc(document.id)
        .update({"id": document.id});
  }

  Stream<List<Post>> fetchPosts({
    required String userId,
  }) {
    return _collection(userId: userId).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }

  Future<void> deletePost(Post post) async {
    await _collection(userId: post.userId).doc(post.id).delete();
  }
}
