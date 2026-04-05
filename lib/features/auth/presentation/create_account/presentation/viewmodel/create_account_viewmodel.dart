import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/repository/auth_repository.dart';
import '../../../../../../core/di/providers.dart';
import 'create_account_state.dart';
import '../../../../../setup_profile_pages/setup_profile/data/models/profile_model.dart';

class CreateAccountViewModel extends StateNotifier<CreateAccountState> {
  final AuthRepository repository;
  final Ref ref;

  CreateAccountViewModel(this.repository, this.ref)
      : super(const CreateAccountState());

  void updateName(String v) => state = state.copyWith(fullName: v);
  void updateEmail(String v) => state = state.copyWith(email: v);
  void updatePassword(String v) => state = state.copyWith(password: v);
  void toggleRememberMe(bool v) => state = state.copyWith(rememberMe: v);

  Future<void> register() async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);

    try {
      // 1. Register on server
      await repository.register(
        name: state.fullName.trim(),
        email: state.email.trim(),
        password: state.password,
        phone: '+1234567890',
        country: 'United States',
        city: 'New York',
      );

      // 2. Auto-login to get tokens
      await repository.login(
        email: state.email.trim(),
        password: state.password,
      );

      // 3. Set session email
      final email = state.email.trim();
      await ref.read(userSessionProvider.notifier).setUser(email);

      await _seedLocalProfile(email, state.fullName.trim());

      ref.invalidate(userProfileProvider);
      ref.invalidate(userAddressesProvider);

      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      debugPrint('❌ Register error: $e');
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: _mapError(e),
      );
    }
  }

  Future<void> _seedLocalProfile(String email, String fullName) async {
    try {
      final localStorage = ref.read(localStorageProvider);
      final model = ProfileModel(
        fullName: fullName,
        email: email,
        phone: '',
        gender: '',
        imagePath: null,
      );
      await localStorage.saveProfile(email, model.toJson());
      debugPrint('✅ Seeded local profile: fullName="$fullName" email="$email"');
    } catch (e) {
      debugPrint('⚠️ Could not seed local profile: $e');
    }
  }

  String _mapError(Object e) {
    final msg = e.toString().toLowerCase();

    if (msg.contains('socketexception') || msg.contains('network')) {
      return "No internet connection";
    }
    if (msg.contains('timeout')) {
      return "Request timeout. Try again";
    }
    if (msg.contains('already') ||
        msg.contains('exists') ||
        msg.contains('registered')) {
      return "Email already registered";
    }
    if (msg.contains('invalid email')) {
      return "Invalid email address";
    }
    if (msg.contains('password') && msg.contains('short')) {
      return "Password must be at least 6 characters";
    }
    if (msg.contains('weak password')) {
      return "Password is too weak";
    }

    return "Something went wrong. Please try again";
  }
}