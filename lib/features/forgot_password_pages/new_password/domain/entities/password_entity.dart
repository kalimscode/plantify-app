class PasswordEntity {
  final String password;
  final String confirmPassword;
  final bool rememberMe;

  const PasswordEntity({
    required this.password,
    required this.confirmPassword,
    required this.rememberMe,
  });

  bool get isValid =>
      password.isNotEmpty &&
          confirmPassword.isNotEmpty &&
          password == confirmPassword;

  PasswordEntity copyWith({
    String? password,
    String? confirmPassword,
    bool? rememberMe,
  }) {
    return PasswordEntity(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  String toString() =>
      'PasswordEntity(password: $password, confirmPassword: $confirmPassword, rememberMe: $rememberMe)';
}
