import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodtracker/features/authentication/domain/entities/app_user.dart';
import 'package:moodtracker/features/authentication/domain/repositories/auth_repository.dart';

part 'app_state.dart';

class AppBloc extends Cubit<AppState> {
  AppBloc({required this.authRepository})
      : super(
          authRepository.currentUser.isEmpty
              ? AppState.unauthenticated()
              : AppState.authenticated(user: authRepository.currentUser),
        ) {
    _userSubscription = authRepository.user.listen(_onUserChanged);
  }

  final AuthRepository authRepository;
  StreamSubscription? _userSubscription;

  void _onUserChanged(AppUser user) {
    emit(
      user.isEmpty
          ? AppState.unauthenticated()
          : AppState.authenticated(user: user),
    );
  }

  bool get loggedIn => state.user != const AppUser.empty();

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
