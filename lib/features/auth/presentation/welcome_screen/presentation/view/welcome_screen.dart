import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/di/providers.dart';
import '../../../../../../core/shared_widgets/social_media_login/login_buttons.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_typography.dart';
import '../../../../../../router.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(welcomeViewModelProvider);
    final viewModel = ref.read(welcomeViewModelProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
        body: Column(
          children: [
        Expanded(
        child: Stack(
        fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/welcome_screen_image.png',
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            Positioned(
              top: 76.h,
              left: 24.w,
              right: 24.w,
              child: Column(
                children: [
                  Image.asset(
                    'assets/logos/plantify_logo.png',
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    "Let's Get Growing: Start Your Plant Journey with Our App!",
                    textAlign: TextAlign.center,
                    style: AppTypography.h6Bold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(24.w, 52.h, 24.w,  52.h + MediaQuery.of(context).padding.bottom,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColors.dark500 : AppColors.white500,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          Text(
          'Continue with',
          style: AppTypography.bodyMediumMedium.copyWith(
            color: AppColors.main500,
          ),
        ),

        SizedBox(height: 24.h),

        SocialLoginButtons(),

        SizedBox(height: 24.h),

        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRouter.createAccount);
          },
          child: Text.rich(
            TextSpan(
              children: [
            TextSpan(
            text: "do you haven't an account? ",
            style: AppTypography.bodyMediumRegular.copyWith(
            color: isDark
            ? AppColors.fontWhite
                : AppColors.fontBlack,
            ),
          ),
          TextSpan(
            text: 'Sign Up',
            style: AppTypography.bodyMediumBold.copyWith(
              color: AppColors.main500,
            ),
          ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    ),

    SizedBox(height: 24.h),
    ],
    ),
    ),
    ],
    ),
    ),
    );
  }
}