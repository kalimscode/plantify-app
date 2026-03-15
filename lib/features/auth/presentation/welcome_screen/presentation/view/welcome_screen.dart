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
    final viewModel =
    ref.read(welcomeViewModelProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
        body: SizedBox(
          width: 428.w,
          height: 926.h,
          child: Stack(
            children: [
              Container(
                width: 428.w,
                height: 526.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/welcome_screen_image.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 428.w,
                height: 526.h,
                color: Colors.black.withOpacity(0.5),
              ),

              Positioned(
                top: 76.h,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      Image.asset('assets/logos/plantify_logo.png', fit: BoxFit.contain),
                      SizedBox(height: 32.h),
                      SizedBox(
                        width: 380.w,
                        child: Text(
                          "Let's Get Growing: Start Your Plant Journey with Our App!",
                          textAlign: TextAlign.center,
                          style: AppTypography.h6Bold.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  width: 428.w,
                  height: 420.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 52.h,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.dark500 : AppColors.white500,                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.r)),
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

                      SocialLoginButtons(

                      ),

                      SizedBox(height: 24.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRouter.createAccount,
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'do you haven’t an account? ',
                                style:
                                AppTypography.bodyMediumRegular.copyWith(
                                  color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                                )
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}