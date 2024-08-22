part of 'sign_up_cubit.dart';

enum SignUpStatus {
  initial,
  loading,
  success,
  failure,
}

class SignUpState {
  SignUpState._({
    required this.status,
    this.emailErrorMessage,
    this.passwordErrorMessage,
    this.errorMessage,
  });

  SignUpState.initial() : this._(status: SignUpStatus.initial);
  SignUpState.loading() : this._(status: SignUpStatus.loading);
  SignUpState.success() : this._(status: SignUpStatus.success);
  SignUpState.failure({
    String? emailErrorMessage,
    String? passwordErrorMessage,
    String? errorMessage,
  }) : this._(
          status: SignUpStatus.failure,
          emailErrorMessage: emailErrorMessage,
          passwordErrorMessage: passwordErrorMessage,
          errorMessage: errorMessage,
        );

  final SignUpStatus status;
  final String? emailErrorMessage;
  final String? passwordErrorMessage;
  final String? errorMessage;

  bool get isInitial => status == SignUpStatus.initial;
  bool get isLoading => status == SignUpStatus.loading;
  bool get isSuccess => status == SignUpStatus.success;
  bool get isFailure => status == SignUpStatus.failure;
}
