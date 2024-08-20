import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/authentication/domain/entities/login_exception.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

class AuthRepository {
  final _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  bool get loggedIn => user != null;

  Future<UserCredential> createUser({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-email") {
        throw InvalidEmailLoginException("Email doesn't exist.");
      }

      if (error.code == "invalid-credential") {
        throw InvalidPasswordLoginException("Wrong password.");
      }

      throw LoginException(error.message ?? "Unknown error");
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
