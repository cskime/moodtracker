import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moodtracker/features/app/views/moodtracker_app.dart';
import 'package:moodtracker/features/authentication/data/data_providers/auth_provider/firebase_auth_provider.dart';
import 'package:moodtracker/features/authentication/data/repositories/auth_repository.dart';
import 'package:moodtracker/features/post/data/providers/firestore_provider.dart';
import 'package:moodtracker/features/post/data/repositories/post_repository_impl.dart';
import 'package:moodtracker/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebaseAuthProvider = FirebaseAuthProvider();
  final authRepository = AuthRepositoryImpl(authProvider: firebaseAuthProvider);

  final firestoreProvider = FirestoreProvider();
  final postRepository =
      PostRepositoryImpl(databaseProvider: firestoreProvider);

  runApp(
    MoodtrackerApp(
      authRepository: authRepository,
      postRepository: postRepository,
    ),
  );
}
