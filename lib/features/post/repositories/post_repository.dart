import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/post/models/post.dart';

final postRepositoryProvider = Provider((ref) => PostRepository());

class PostRepository {
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  Future<void> createPost(Post post) async {
    await _database
        .collection("users")
        .doc(post.userId)
        .collection("posts")
        .withConverter(
          fromFirestore: Post.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .add(post);
  }
}
