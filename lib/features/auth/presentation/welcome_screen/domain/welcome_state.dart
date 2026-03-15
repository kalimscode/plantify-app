class WelcomeState {
  final bool isLoading;

  const WelcomeState({
    this.isLoading = false,
  });

  WelcomeState copyWith({
    bool? isLoading,
  }) {
    return WelcomeState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
