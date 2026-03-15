import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/forgot_password_entity.dart';

class ForgotPasswordViewModel extends StateNotifier<ForgotPasswordEntity> {
  ForgotPasswordViewModel() : super(const ForgotPasswordEntity(emailOrPhone: ''));

  void updateEmailOrPhone(String value) {
    state = state.copyWith(emailOrPhone: value);
  }

  bool get isValid => state.emailOrPhone.isNotEmpty;

  Future<void> submit() async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO: Implement backend or Firebase reset logic
  }
}
