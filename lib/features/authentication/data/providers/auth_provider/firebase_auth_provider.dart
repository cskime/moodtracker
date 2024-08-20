import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:moodtracker/features/authentication/data/providers/auth_provider/auth_provider.dart';
import 'package:moodtracker/features/authentication/domain/entities/app_user.dart';
import 'package:moodtracker/features/authentication/domain/entities/login_exception.dart';

class FirebaseAuthProvider extends AuthProvider {
  final _auth = firebase_auth.FirebaseAuth.instance;

  @override
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  AppUser? get loggedInUser {
    if (_auth.currentUser == null) {
      return null;
    }

    return AppUser(id: _auth.currentUser!.uid);
  }

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
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
    _auth.signOut();
  }
}
