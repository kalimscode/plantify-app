enum AuthStatus {
  initial,
  loading,
  success,
  error,
}

class LoginAccountModel {
  final String email;
  final String password;
  final bool rememberMe;
  final AuthStatus status;
  final String? errorMessage;

  const LoginAccountModel({
    this.email = '',
    this.password = '',
    this.rememberMe = false,
    this.status = AuthStatus.initial,
    this.errorMessage,
  });

  LoginAccountModel copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    AuthStatus? status,
    String? errorMessage,
  }) {
    return LoginAccountModel(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  /// ✅ Computed getters
  bool get isLoading => status == AuthStatus.loading;

  bool get isSuccess => status == AuthStatus.success;

  bool get isError => status == AuthStatus.error;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;
}
