part of 'login_cubit.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  failure,
}

class LoginState {
  LoginState._(
      {required this.status,
      this.emailErrorMessage,
      this.passwordErrorMessage,
      this.errorMessage});

  LoginState.initial() : this._(status: LoginStatus.initial);
  LoginState.loading() : this._(status: LoginStatus.loading);
  LoginState.success() : this._(status: LoginStatus.success);
  LoginState.failure({
    String? emailErrorMessage,
    String? passwordErrorMessage,
    String? errorMessage,
  }) : this._(
          status: LoginStatus.failure,
          emailErrorMessage: emailErrorMessage,
          passwordErrorMessage: passwordErrorMessage,
          errorMessage: errorMessage,
        );

  final LoginStatus status;
  final String? emailErrorMessage;
  final String? passwordErrorMessage;
  final String? errorMessage;

  bool get isInitial => status == LoginStatus.initial;
  bool get isLoading => status == LoginStatus.loading;
  bool get isSuccess => status == LoginStatus.success;
  bool get isFailure => status == LoginStatus.failure;
}
