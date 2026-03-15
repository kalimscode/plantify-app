enum AuthStatus { initial, loading, success, error }

class CreateAccountState {
  final String fullName;
  final String email;
  final String password;
  final bool rememberMe;
  final AuthStatus status;
  final String? errorMessage;

  const CreateAccountState({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.rememberMe = false,
    this.status = AuthStatus.initial,
    this.errorMessage,
  });

  bool get isFormValid =>
      fullName.isNotEmpty && email.isNotEmpty && password.isNotEmpty;

  bool get isLoading => status == AuthStatus.loading;

  CreateAccountState copyWith({
    String? fullName,
    String? email,
    String? password,
    bool? rememberMe,
    AuthStatus? status,
    String? errorMessage,
  }) {
    return CreateAccountState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
