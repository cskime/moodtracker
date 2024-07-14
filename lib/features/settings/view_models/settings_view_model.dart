import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/authentication/repositories/auth_repository.dart';

final settingsViewModelProvider =
    AsyncNotifierProvider.autoDispose(SettingsViewModel.new);

class SettingsViewModel extends AutoDisposeAsyncNotifier {
  late final AuthRepository _authRepository;

  @override
  FutureOr build() {
    _authRepository = ref.read(authRepositoryProvider);
  }

  Future<void> logOut() async {
    await _authRepository.signOut();
  }
}
