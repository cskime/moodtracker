import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodtracker/features/authentication/domain/entities/app_user.dart';
import 'package:moodtracker/features/authentication/domain/repositories/auth_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required this.authRepository})
      : super(
          authRepository.currentUser.isEmpty
              ? AppState.unauthenticated()
              : AppState.authenticated(user: authRepository.currentUser),
        ) {
    on<AppUserChanged>(_onUserChanged);
    _userSubscription = authRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  final AuthRepository authRepository;
  StreamSubscription? _userSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isEmpty
          ? AppState.unauthenticated()
          : AppState.authenticated(user: event.user),
    );
  }

  bool get loggedIn => state.user != const AppUser.empty();

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
