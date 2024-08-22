import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/app/views/moodtracker_app.dart';
import 'package:moodtracker/features/authentication/data/data_providers/auth_provider/firebase_auth_provider.dart';
import 'package:moodtracker/features/authentication/data/repositories/auth_repository.dart';
import 'package:moodtracker/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebaseAuthProvider = FirebaseAuthProvider();
  final authRepository = AuthRepositoryImpl(authProvider: firebaseAuthProvider);

  runApp(
    ProviderScope(
      child: MoodtrackerApp(
        authRepository: authRepository,
      ),
    ),
  );
}
