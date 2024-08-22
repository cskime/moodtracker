import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodtracker/features/authentication/domain/repositories/auth_repository.dart';
import 'package:moodtracker/features/authentication/presentation/utils/validation_service.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.authRepository}) : super(SignUpState.initial());

  final AuthRepository authRepository;
  final _validationService = ValidationService();

  String? validateEmail(String? email) {
    return _validationService.validateEmail(email);
  }

  String? validatePassword(String? password) {
    return _validationService.validatePassword(password);
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    emit(SignUpState.loading());
    await authRepository.createUser(email: email, password: password);
    emit(SignUpState.success());
  }
}
