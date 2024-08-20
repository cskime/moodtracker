import 'package:moodtracker/features/authentication/domain/entities/app_user.dart';

abstract class AuthProvider {
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  AppUser? get loggedInUser;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
