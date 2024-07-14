import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/authentication/repositories/auth_repository.dart';
import 'package:moodtracker/features/authentication/services/validation_service.dart';

final loginViewModelProvider =
    AsyncNotifierProvider.autoDispose(LoginViewModel.new);

class LoginViewModel extends AutoDisposeAsyncNotifier {
  late final AuthRepository _authRepository;
  late final ValidationService _validationService;

  @override
  FutureOr build() {
    _authRepository = ref.read(authRepositoryProvider);
    _validationService = ValidationService();
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(() async {
      await _authRepository.signIn(
        email: email,
        password: password,
      );
    });
    state = result;
    return !result.hasError;
  }

  String? validateEmail(String? email) {
    return _validationService.validateEmail(email);
  }

  String? validatePassword(String? password) {
    return _validationService.validatePassword(password);
  }
}
