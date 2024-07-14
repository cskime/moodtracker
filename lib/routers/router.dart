import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moodtracker/features/authentication/repositories/auth_repository.dart';
import 'package:moodtracker/features/authentication/views/login_screen.dart';
import 'package:moodtracker/features/authentication/views/sign_up_screen.dart';
import 'package:moodtracker/features/navigation/models/navigation_tab.dart';
import 'package:moodtracker/features/navigation/views/main_navigation.dart';
import 'package:moodtracker/features/post/views/write_screen.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: WriteScreen.routeUrl,
    redirect: (context, state) {
      final loggedIn = ref.read(authRepositoryProvider).loggedIn;

      print(loggedIn);
      print(state.fullPath);

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
