import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/post/models/post.dart';

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
    await _collection(userId: post.userId).add(post);
  }

  Future<List<Post>> fetchPosts({
    required String userId,
  }) async {
    final snapshot = await _collection(userId: userId).get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
