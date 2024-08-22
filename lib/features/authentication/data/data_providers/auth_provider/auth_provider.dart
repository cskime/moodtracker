import 'package:moodtracker/features/authentication/domain/entities/app_user.dart';

abstract class AuthProvider {
  Stream<AppUser> get user;

  AppUser get currentUser;

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
