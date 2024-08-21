import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodtracker/features/authentication/data/providers/auth_provider/firebase_auth_provider.dart';
import 'package:moodtracker/features/authentication/data/repositories/auth_repository.dart';
import 'package:moodtracker/features/authentication/domain/repositories/auth_repository.dart';
import 'package:moodtracker/routers/router.dart';
import 'package:moodtracker/themes/light_theme.dart';

class MoodtrackerApp extends StatelessWidget {
  const MoodtrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            authProvider: FirebaseAuthProvider(),
          ),
        )
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        theme: lightTheme,
      ),
    );
  }
}
