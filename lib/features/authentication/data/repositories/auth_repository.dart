import 'package:moodtracker/features/authentication/data/data_providers/auth_provider/auth_provider.dart';
import 'package:moodtracker/features/authentication/domain/entities/app_user.dart';
import 'package:moodtracker/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({
    required this.authProvider,
  });

  final AuthProvider authProvider;

  @override
  Stream<AppUser> get user => authProvider.user;

  @override
  AppUser get currentUser => authProvider.currentUser;

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
