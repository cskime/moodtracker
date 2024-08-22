import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodtracker/features/app/blocs/app_bloc.dart';
import 'package:moodtracker/features/app/views/navigation/main_navigation.dart';
import 'package:moodtracker/features/authentication/domain/repositories/auth_repository.dart';
import 'package:moodtracker/features/authentication/presentation/blocs/login/login_cubit.dart';
import 'package:moodtracker/features/authentication/presentation/views/login_screen.dart';
import 'package:moodtracker/themes/light_theme.dart';

class MoodtrackerApp extends StatelessWidget {
  const MoodtrackerApp({
    super.key,
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>(
      create: (context) => authRepository,
      child: BlocProvider(
        create: (context) => AppBloc(authRepository: authRepository),
        child: MaterialApp(
          theme: lightTheme,
          home: BlocSelector<AppBloc, AppState, AppStatus>(
            selector: (state) => state.status,
            builder: (context, state) => switch (state) {
              AppStatus.unauthenticated => BlocProvider(
                  create: (context) =>
                      LoginCubit(authRepository: authRepository),
                  child: const LoginScreen(),
                ),
              AppStatus.authenticated => const MainNavigation(),
            },
          ),
        ),
      ),
    );
  }
}
