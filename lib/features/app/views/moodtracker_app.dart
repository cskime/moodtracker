import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodtracker/features/app/blocs/app_bloc.dart';
import 'package:moodtracker/features/app/views/navigation/main_navigation.dart';
import 'package:moodtracker/features/authentication/domain/repositories/auth_repository.dart';
import 'package:moodtracker/features/authentication/presentation/blocs/login/login_cubit.dart';
import 'package:moodtracker/features/authentication/presentation/views/login_screen.dart';
import 'package:moodtracker/features/post/domain/repositories/post_repository.dart';
import 'package:moodtracker/features/post/presentation/blocs/calendar/calendar_cubit.dart';
import 'package:moodtracker/features/post/presentation/blocs/write/write_cubit.dart';
import 'package:moodtracker/features/settings/presentation/blocs/settings_cubit.dart';
import 'package:moodtracker/themes/light_theme.dart';

class MoodtrackerApp extends StatelessWidget {
  const MoodtrackerApp({
    super.key,
    required this.authRepository,
    required this.postRepository,
  });

  final AuthRepository authRepository;
  final PostRepository postRepository;

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
              AppStatus.authenticated => RepositoryProvider(
                  create: (context) => postRepository,
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => WriteCubit(
                          authRepository: authRepository,
                          postRepository: postRepository,
                        ),
                      ),
                      BlocProvider(
                        create: (context) => CalendarCubit(
                          authRepository: authRepository,
                          postRepository: postRepository,
                        ),
                      ),
                      BlocProvider(
                        create: (context) => SettingsCubit(
                          authRepository: authRepository,
                        ),
                      ),
                    ],
                    child: const MainNavigation(),
                  ),
                ),
            },
          ),
        ),
      ),
    );
  }
}
