import 'package:flutter/foundation.dart';

@immutable
class ForgotPasswordOtpState {
  final List<String> otpDigits;
  final bool isVerifying;
  final bool isCompleted;

  const ForgotPasswordOtpState({
    this.otpDigits = const ['', '', '', ''],
    this.isVerifying = false,
    this.isCompleted = false,
  });

  ForgotPasswordOtpState copyWith({
    List<String>? otpDigits,
    bool? isVerifying,
    bool? isCompleted,
  }) {
    return ForgotPasswordOtpState(
      otpDigits: otpDigits ?? this.otpDigits,
      isVerifying: isVerifying ?? this.isVerifying,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
