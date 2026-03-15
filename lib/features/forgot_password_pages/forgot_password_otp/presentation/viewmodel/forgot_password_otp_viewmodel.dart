import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'forgot_password_otp_state.dart';

class ForgotPasswordOtpViewModel extends StateNotifier<ForgotPasswordOtpState> {
  ForgotPasswordOtpViewModel() : super(const ForgotPasswordOtpState());

  void updateOtpDigit(int index, String value) {
    final updatedDigits = [...state.otpDigits];
    updatedDigits[index] = value;
    final isCompleted = updatedDigits.every((d) => d.isNotEmpty);

    state = state.copyWith(
      otpDigits: updatedDigits,
      isCompleted: isCompleted,
    );
  }

  Future<void> verifyOtp() async {
    if (!state.isCompleted) return;

    state = state.copyWith(isVerifying: true);

    await Future.delayed(const Duration(seconds: 2)); // simulate network

    state = state.copyWith(isVerifying: false);
    // TODO: Add repository call or navigation
  }

  void resetOtp() {
    state = const ForgotPasswordOtpState();
  }
}
