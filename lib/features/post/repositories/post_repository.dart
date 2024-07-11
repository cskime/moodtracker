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

  Stream<List<Post>> fetchPosts({
    required String userId,
  }) {
    return _collection(userId: userId).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }
}
