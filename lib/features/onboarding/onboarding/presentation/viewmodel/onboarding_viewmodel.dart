import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/onboarding_local_datasource.dart';
import 'onboarding_state.dart';

class OnboardingViewModel extends StateNotifier<OnboardingState> {
  final OnboardingLocalDataSource _dataSource;
  final PageController pageController = PageController();

  OnboardingViewModel(this._dataSource)
      : super(
    OnboardingState(
      pages: _dataSource.getPages(),
    ),
  );

  void onPageChanged(int index) {
    if (index == state.currentPage) return;
    state = state.copyWith(currentPage: index);
  }

  void nextPage() {
    if (state.currentPage >= state.pages.length - 1) return;

    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void skip() {
    pageController.jumpToPage(state.pages.length - 1);
  }

  @override
  void dispose() {
    pageController.dispose(); // 🔥 VERY IMPORTANT
    super.dispose();
  }
}
