import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:moodtracker/features/authentication/data/data_providers/auth_provider/auth_provider.dart';
import 'package:moodtracker/features/authentication/domain/entities/app_user.dart';
import 'package:moodtracker/features/authentication/domain/entities/login_exception.dart';

class FirebaseAuthProvider extends AuthProvider {
  final _auth = firebase_auth.FirebaseAuth.instance;

  @override
  Stream<AppUser> get user => _auth.authStateChanges().map(
        (user) => user == null ? const AppUser.empty() : AppUser(id: user.uid),
      );

  @override
  AppUser get currentUser {
    final currentUser = _auth.currentUser;
    return currentUser == null
        ? const AppUser.empty()
        : AppUser(id: currentUser.uid);
  }

  @override
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (error) {
      if (error.code == "invalid-email") {
        throw InvalidEmailLoginException("Email doesn't exist.");
      }

      if (error.code == "invalid-credential") {
        throw InvalidPasswordLoginException("Wrong password.");
      }

      throw LoginException(error.message ?? "Unknown error");
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
