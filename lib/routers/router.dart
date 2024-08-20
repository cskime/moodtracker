import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/features/authentication/data/repositories/auth_repository.dart';
import 'package:moodtracker/features/authentication/presentation/views/login_screen.dart';
import 'package:moodtracker/features/authentication/presentation/views/sign_up_screen.dart';
import 'package:moodtracker/features/navigation/navigation_tab.dart';
import 'package:moodtracker/features/navigation/main_navigation.dart';
import 'package:moodtracker/features/post/presentation/views/write_screen.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: WriteScreen.routeUrl,
    redirect: (context, state) {
      final loggedIn = ref.read(authRepositoryProvider).loggedIn;

      if (!loggedIn &&
          state.fullPath != LoginScreen.routeUrl &&
          state.fullPath != SignUpScreen.routeUrl) {
        return LoginScreen.routeUrl;
      }

      return null;
    },
    routes: [
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routeUrl,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: SignUpScreen.routeName,
        path: SignUpScreen.routeUrl,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: "/:tab(${NavigationTab.pathParameterString})",
        builder: (context, state) => MainNavigation(
          tab: NavigationTab.name(state.pathParameters["tab"]!),
        ),
      ),
    ],
  ),
);
