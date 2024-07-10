import 'package:go_router/go_router.dart';
import 'package:moodtracker/features/authentication/views/login_screen.dart';
import 'package:moodtracker/features/authentication/views/sign_up_screen.dart';

final router = GoRouter(
  initialLocation: LoginScreen.routeUrl,
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
  ],
);
