import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodtracker/features/authentication/data/repositories/auth_repository.dart';
import 'package:moodtracker/features/authentication/presentation/utils/validation_service.dart';

final signUpViewModelProvider =
    AsyncNotifierProvider.autoDispose(SignUpViewModel.new);

class SignUpViewModel extends AutoDisposeAsyncNotifier {
  late final AuthRepository _authRepository;
  late final ValidationService _validationService;

  @override
  FutureOr build() {
    _authRepository = ref.read(authRepositoryProvider);
    _validationService = ValidationService();
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    try {
      final credential = await _authRepository.createUser(
        email: email,
        password: password,
      );
      state = AsyncValue.data(credential);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  String? validateEmail(String? email) {
    return _validationService.validateEmail(email);
  }

  String? validatePassword(String? password) {
    return _validationService.validatePassword(password);
  }
}
