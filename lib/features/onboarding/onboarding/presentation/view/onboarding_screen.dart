import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/providers.dart';
import '../../../../../core/shared_widgets/action_buttons/action_button.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../router.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingViewModelProvider);
    final viewModel = ref.read(onboardingViewModelProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      body: Stack(
        children: [
          SizedBox(
            width: 1.sw,
            height: 462.h,
            child: PageView.builder(
              controller: viewModel.pageController,
              itemCount: state.pages.length,
              onPageChanged: viewModel.onPageChanged,
              itemBuilder: (context, index) {
                final page = state.pages[index];
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      page.imagePath,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.20),
                    ),
                  ],
                );
              },
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 1.sw,
              height: 464.h,
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 24.h,
              ),
              decoration: BoxDecoration(
                color: isDark ? AppColors.dark500 : AppColors.white500,
              ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    SizedBox(
    height: 8.h,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
    state.pages.length,
    (index) => Container(
    margin: EdgeInsets.symmetric(horizontal: 4.w),
    width: 8.w,
    height: 8.w,
    decoration: ShapeDecoration(
    color: state.currentPage == index
    ? AppColors.main500
        : AppColors.main100,
    shape: const OvalBorder(),
    ),
    ),
    ),
    ),
    ),

    SizedBox(height: 22.h),

    SizedBox(
    height: 58.h,
    child: Text(
    state.pages[state.currentPage].title,
    style: AppTypography.h5Bold.copyWith(
    color: isDark
    ? AppColors.fontWhite
        : AppColors.fontBlack,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    height: 1.3,
    ),
    ),
    ),

    SizedBox(height: 13.h),

    SizedBox(
    height: 110.h,
    child: Text(
    state.pages[state.currentPage].description,
    softWrap: true,
    overflow: TextOverflow.visible,
    style: AppTypography.bodyMediumRegular.copyWith(
    color: isDark
    ? AppColors.fontWhite
        : AppColors.fontBlack,
    fontSize: 15.8.sp,
    fontWeight: FontWeight.w500,
    ),
    ),
    ),

    SizedBox(height: 28.h),

    SizedBox(
    child: Column(
    children: [
    ActionButton(
    text: 'Get Started',
    variant: ButtonVariant.primary,
    size: ButtonSize.full,
    onPressed: () {
    if (state.currentPage ==
    state.pages.length - 1) {
    Navigator.pushReplacementNamed(
    context,
    AppRouter.welcome,
    );
    } else {
    viewModel.nextPage();
    }
    },
    ),
    SizedBox(height: 10.h),
    ActionButton(
    text: 'Skip',
    variant: ButtonVariant.secondary,
    size: ButtonSize.full,
    onPressed: () {
    Navigator.pushReplacementNamed(
    context,
    AppRouter.welcome,
    );
    },
    ),
    ],
    ),
    ),
    ],
    )))]));
  }}

