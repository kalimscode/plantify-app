class ForgotPasswordEntity {
  final String emailOrPhone;

  const ForgotPasswordEntity({required this.emailOrPhone});

  ForgotPasswordEntity copyWith({String? emailOrPhone}) {
    return ForgotPasswordEntity(
      emailOrPhone: emailOrPhone ?? this.emailOrPhone,
    );
  }
}
