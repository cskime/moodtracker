// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodtracker/features/app/views/moodtracker_app.dart';
import 'package:moodtracker/features/authentication/domain/entities/app_user.dart';
import 'package:moodtracker/features/authentication/domain/repositories/auth_repository.dart';
import 'package:moodtracker/features/post/domain/entities/post.dart';
import 'package:moodtracker/features/post/domain/repositories/post_repository.dart';

class AuthRepositoryMock extends AuthRepository {
  @override
  Future<void> createUser({required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<void> signIn({required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  @override
  AppUser get currentUser => throw UnimplementedError();

  @override
  Stream<AppUser> get user => throw UnimplementedError();
}

class PostRepositoryMock extends PostRepository {
  @override
  Future<void> createPost(Post post) {
    throw UnimplementedError();
  }

  @override
  Future<void> deletePost(Post post) {
    throw UnimplementedError();
  }

  @override
  Stream<List<Post>> posts({required String userId}) {
    throw UnimplementedError();
  }
}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MoodtrackerApp(
        authRepository: AuthRepositoryMock(),
        postRepository: PostRepositoryMock(),
      ),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
