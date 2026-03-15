import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/password_entity.dart';

class NewPasswordState {
  final PasswordEntity passwordEntity;
  final bool isLoading;
  final bool isSuccess;

  const NewPasswordState({
    this.passwordEntity = const PasswordEntity(
      password: '',
      confirmPassword: '',
      rememberMe: false,
    ),
    this.isLoading = false,
    this.isSuccess = false,
  });

  NewPasswordState copyWith({
    PasswordEntity? passwordEntity,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return NewPasswordState(
      passwordEntity: passwordEntity ?? this.passwordEntity,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class NewPasswordViewModel extends StateNotifier<NewPasswordState> {
  NewPasswordViewModel() : super(const NewPasswordState());

  void setPassword(String value) => state = state.copyWith(
    passwordEntity: state.passwordEntity.copyWith(password: value),
    isSuccess: false,
  );

  void setConfirmPassword(String value) => state = state.copyWith(
    passwordEntity: state.passwordEntity.copyWith(confirmPassword: value),
    isSuccess: false,
  );

  void toggleRememberMe() => state = state.copyWith(
    passwordEntity: state.passwordEntity.copyWith(
      rememberMe: !state.passwordEntity.rememberMe,
    ),
  );

  Future<void> submit() async {
    if (!state.passwordEntity.isValid) return;

    state = state.copyWith(isLoading: true);

    await Future.delayed(const Duration(seconds: 1)); // mock network delay

    state = state.copyWith(isLoading: false, isSuccess: true);
  }
}
