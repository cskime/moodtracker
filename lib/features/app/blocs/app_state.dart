part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState {
  AppState({
    required this.status,
    required this.user,
  });

  AppState.authenticated({required AppUser user})
      : this(
          status: AppStatus.authenticated,
          user: user,
        );

  AppState.unauthenticated()
      : this(
          status: AppStatus.unauthenticated,
          user: const AppUser.empty(),
        );

  final AppStatus status;
  final AppUser user;
}
