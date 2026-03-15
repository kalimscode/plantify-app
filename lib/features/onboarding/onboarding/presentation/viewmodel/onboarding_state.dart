import '../../domain/onboarding_page_model.dart';

class OnboardingState {
  final int currentPage;
  final List<OnboardingPageModel> pages;

  const OnboardingState({
    this.currentPage = 0,
    this.pages = const [],
  });

  OnboardingState copyWith({
    int? currentPage,
    List<OnboardingPageModel>? pages,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      pages: pages ?? this.pages,
    );
  }
}
