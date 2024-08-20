import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodtracker/features/post/data/providers/database_provider.dart';
import 'package:moodtracker/features/post/domain/entities/post.dart';

class FirestoreProvider extends DatabaseProvider {
  final _database = FirebaseFirestore.instance;

  CollectionReference<Post> _collection({required String userId}) => _database
      .collection("users")
      .doc(userId)
      .collection("posts")
      .withConverter<Post>(
        fromFirestore: Post.fromFirestore,
        toFirestore: (value, options) => value.toFirestore(),
      );

  @override
  Future<void> createPost(Post post) async {
    final document = await _collection(userId: post.userId).add(post);
    await _collection(userId: post.userId)
        .doc(document.id)
        .update({"id": document.id});
  }

  @override
  Future<void> deletePost(Post post) async {
    await _collection(userId: post.userId).doc(post.id).delete();
  }

  @override
  Stream<List<Post>> fetchPostsByUserId(String userId) {
    return _collection(userId: userId).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }
}
