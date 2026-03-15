import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';
import 'package:plantify/core/shared_widgets/action_buttons/action_button.dart';
import '../../../../../core/di/providers.dart';
import '../../../../../core/shared_widgets/action_buttons/action_checkbox.dart';
import '../../../../../core/shared_widgets/form_fields/app_input_field/app_input_field.dart';
import '../../../../../core/shared_widgets/social_media_login/login_buttons.dart';
import '../../../../../router.dart';
import '../widgets/success_popup.dart';

class NewPasswordScreen extends ConsumerWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(newPasswordViewModelProvider);
    final notifier = ref.read(newPasswordViewModelProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter New\nPassword',
                  style: AppTypography.h4Bold.copyWith(
                    color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                  ),
                ),
                SizedBox(height: 32.h),

                AppInputField(
                  label: 'New Password',
                  hintText: 'Enter new password',
                  isPassword: true,
                  controller: TextEditingController(
                    text: vm.passwordEntity.password,
                  ),
                  onChanged: notifier.setPassword,
                ),
                SizedBox(height: 24.h),

                AppInputField(
                  label: 'Confirm Password',
                  hintText: 'Re-enter new password',
                  isPassword: true,
                  controller: TextEditingController(
                    text: vm.passwordEntity.confirmPassword,
                  ),
                  onChanged: notifier.setConfirmPassword,
                ),
                SizedBox(height: 24.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ActionCheckbox(
                          value: vm.passwordEntity.rememberMe,
                          onChanged: (_) => notifier.toggleRememberMe(),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Remember me',
                          style: AppTypography.bodySmallRegular.copyWith(
                            color:
                            isDark ? AppColors.fontWhite : AppColors.fontBlack,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, AppRouter.forgotPassword),
                      child: Text(
                        'Forgot Password?',
                        style: AppTypography.bodySmallBold.copyWith(
                          color:
                          isDark ? AppColors.fontWhite : AppColors.fontBlack,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => const SuccessPopup(),
                    );
                  },
                  child: ActionButton(text: 'Sign in'),
                ),
                SizedBox(height: 32.h),

                Center(
                  child: Text(
                    'or continue with',
                    style: AppTypography.bodyMediumMedium.copyWith(
                      color: AppColors.main500,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                const SocialLoginButtons(),
                SizedBox(height: 24.h),

                Center(
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRouter.createAccount),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account? ",
                            style: AppTypography.bodyMediumRegular.copyWith(
                              color: isDark
                                  ? AppColors.fontWhite
                                  : AppColors.fontBlack,
                            ),
                          ),
                          TextSpan(
                            text: "Sign Up",
                            style: AppTypography.bodyMediumBold.copyWith(
                              color: AppColors.main500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 175.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
