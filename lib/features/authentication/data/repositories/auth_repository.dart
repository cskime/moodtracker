import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/authentication/data/providers/auth_provider/auth_provider.dart';
import 'package:moodtracker/features/authentication/data/providers/auth_provider/firebase_auth_provider.dart';
import 'package:moodtracker/features/authentication/domain/entities/app_user.dart';
import 'package:moodtracker/features/authentication/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(authProvider: FirebaseAuthProvider()),
);

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({
    required this.authProvider,
  });

  final AuthProvider authProvider;

  @override
  AppUser? get user => authProvider.loggedInUser;

  @override
  Future<void> createUser({
    required String email,
    required String password,
  }) async {
    await authProvider.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await authProvider.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await authProvider.signOut();
  }
}
