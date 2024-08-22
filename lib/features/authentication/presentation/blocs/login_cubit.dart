import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodtracker/features/authentication/domain/entities/login_exception.dart';
import 'package:moodtracker/features/authentication/domain/repositories/auth_repository.dart';
import 'package:moodtracker/features/authentication/presentation/utils/validation_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authRepository}) : super(LoginState.initial());

  final AuthRepository authRepository;
  final _validationService = ValidationService();

  String? validateEmail(String? email) {
    return _validationService.validateEmail(email);
  }

  String? validatePassword(String? password) {
    return _validationService.validatePassword(password);
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginState.loading());
    try {
      await authRepository.signIn(email: email, password: password);
      emit(LoginState.success());
    } on InvalidEmailLoginException catch (error) {
      emit(LoginState.failure(emailErrorMessage: error.message));
    } on InvalidPasswordLoginException catch (error) {
      emit(LoginState.failure(passwordErrorMessage: error.message));
    } on LoginException catch (error) {
      emit(LoginState.failure(errorMessage: error.message));
    }
  }
}
