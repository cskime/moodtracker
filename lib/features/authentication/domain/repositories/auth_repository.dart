import 'package:moodtracker/features/authentication/domain/entities/app_user.dart';

abstract class AuthRepository {
  AppUser? get user;
  bool get loggedIn => user != null;

  Future<void> createUser({
    required String email,
    required String password,
  });

  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
