import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/welcome_repository.dart';
import '../../domain/welcome_state.dart';

class WelcomeViewModel extends StateNotifier<WelcomeState> {
  final WelcomeActions _actions;

  WelcomeViewModel(this._actions)
      : super(const WelcomeState());

  Future<void> onGoogleSignIn() async {
    state = state.copyWith(isLoading: true);
    await _actions.signInWithGoogle();
    state = state.copyWith(isLoading: false);
  }

  Future<void> onAppleSignIn() async {
    state = state.copyWith(isLoading: true);
    await _actions.signInWithApple();
    state = state.copyWith(isLoading: false);
  }
}
