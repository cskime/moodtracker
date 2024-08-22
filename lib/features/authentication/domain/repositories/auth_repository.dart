import 'package:moodtracker/features/authentication/domain/entities/app_user.dart';

abstract class AuthRepository {
  Stream<AppUser> get user;
  AppUser get currentUser;

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
