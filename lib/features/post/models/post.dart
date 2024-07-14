import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post({
    this.id = "",
    required this.userId,
    required this.emotion,
    required this.description,
    required this.date,
  });

  final String id;
  final String userId;
  final String emotion;
  final String description;
  final DateTime date;

  factory Post.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Post(
      id: data?["id"],
      userId: data?["userId"],
      emotion: data?["emotion"],
      description: data?["description"],
      date: (data?["date"] as Timestamp).toDate(),
    );
  }

  Map<String, Object?> toFirestore() => {
        if (id.isNotEmpty) "id": id,
        "userId": userId,
        "emotion": emotion,
        "description": description,
        "date": Timestamp.fromDate(date),
      };
}
