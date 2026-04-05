import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/di/providers.dart';
import '../../../../domain/repository/auth_repository.dart';
import '../../domain/models/login_account_model.dart';

class LoginAccountViewModel extends StateNotifier<LoginAccountModel> {
  final AuthRepository repository;
  final Ref ref;

  LoginAccountViewModel(this.repository, this.ref)
      : super(const LoginAccountModel());

  void updateEmail(String v) => state = state.copyWith(email: v);

  void updatePassword(String v) => state = state.copyWith(password: v);

  void toggleRememberMe(bool value) =>
      state = state.copyWith(rememberMe: value);

  Future<bool> login() async {
    if (state.email.trim().isEmpty) {
      state = state.copyWith(
          status: AuthStatus.error, errorMessage: "Please enter email");
      return false;
    }
    if (state.password.trim().isEmpty) {
      state = state.copyWith(
          status: AuthStatus.error, errorMessage: "Please enter password");
      return false;
    }

    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);

    try {
      await repository.login(
        email: state.email.trim(),
        password: state.password,
      );

      // Set session
      await ref
          .read(userSessionProvider.notifier)
          .setUser(state.email.trim());


      ref.invalidate(userProfileProvider);
      ref.invalidate(userAddressesProvider);

      debugPrint('✅ Login success, session set for: ${state.email}');
      state = state.copyWith(status: AuthStatus.success);
      return true;
    } catch (e) {
      debugPrint('❌ Login error: $e');
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }
}