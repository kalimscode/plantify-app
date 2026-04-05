import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';
import 'package:plantify/core/shared_widgets/action_buttons/action_button.dart';
import '../../../../../../core/di/providers.dart';
import '../../../../../../core/shared_widgets/action_buttons/action_checkbox.dart';
import '../../../../../../core/shared_widgets/form_fields/app_input_field/app_input_field.dart';
import '../../../../../../core/shared_widgets/snackbar/app_snackbar.dart';
import '../../../../../../core/shared_widgets/social_media_login/login_buttons.dart';
import '../../../../../../router.dart';
import '../viewmodel/create_account_state.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  bool _navigated = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createAccountProvider);
    final notifier = ref.read(createAccountProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref.listen<CreateAccountState>(
      createAccountProvider,
          (previous, next) {
        if (previous?.status == next.status) return;

        if (next.status == AuthStatus.success && !_navigated) {
          _navigated = true;

          AppSnackBar.show(
            context,
            message: "Account created successfully",
            type: SnackBarType.success,
          );

          Future.delayed(const Duration(milliseconds: 700), () {
            if (mounted) {
              Navigator.pushReplacementNamed(context, AppRouter.mainWrapper);
            }
          });
        }

        if (next.status == AuthStatus.error && next.errorMessage != null) {
          AppSnackBar.show(
            context,
            message: next.errorMessage!,
            type: SnackBarType.error,
          );
        }
      },
    );

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 30.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE
                Text(
                  'Create Your\nAccount',
                  style: AppTypography.h4Bold.copyWith(
                    color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                    height: 1.22,
                  ),
                ),
                SizedBox(height: 30.h),

                /// FULL NAME
                AppInputField(
                  label: "Full Name",
                  hintText: "Typing your name",
                  leadingIconPath: "assets/SvgIcons/user-02.svg",
                  controller: TextEditingController(text: state.fullName)
                    ..selection = TextSelection.collapsed(
                      offset: state.fullName.length,
                    ),
                  onChanged: notifier.updateName,
                ),
                SizedBox(height: 22.h),

                /// EMAIL
                AppInputField(
                  label: "Email",
                  hintText: "example@yourdomain.com",
                  leadingIconPath: "assets/SvgIcons/mail-02.svg",
                  keyboardType: TextInputType.emailAddress,
                  controller: TextEditingController(text: state.email)
                    ..selection = TextSelection.collapsed(
                      offset: state.email.length,
                    ),
                  onChanged: notifier.updateEmail,
                ),
                SizedBox(height: 22.h),

                /// PASSWORD
                AppInputField(
                  label: "Password",
                  hintText: "Typing your password",
                  leadingIconPath: "assets/SvgIcons/lock-01.svg",
                  isPassword: true,
                  controller: TextEditingController(text: state.password)
                    ..selection = TextSelection.collapsed(
                      offset: state.password.length,
                    ),
                  onChanged: notifier.updatePassword,
                ),
                SizedBox(height: 22.h),

                /// REMEMBER ME
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ActionCheckbox(
                          value: state.rememberMe,
                          onChanged: notifier.toggleRememberMe,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Remember me',
                          style: AppTypography.bodySmallRegular.copyWith(
                            color: isDark
                                ? AppColors.fontWhite
                                : AppColors.fontBlack,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRouter.forgotPassword,
                      ),
                      child: Text(
                        'Forgot Password',
                        style: AppTypography.bodySmallBold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 22.h),

                /// SIGN UP BUTTON
                ActionButton(
                  text: state.isLoading ? "Creating..." : "Sign Up",
                  onPressed: state.isFormValid && !state.isLoading
                      ? notifier.register
                      : null,
                  variant: ButtonVariant.primary,
                ),

                SizedBox(height: 28.h),

                Center(
                  child: Text(
                    'or continue with',
                    style: AppTypography.bodyMediumMedium.copyWith(
                      color: AppColors.main500,
                    ),
                  ),
                ),
                SizedBox(height: 22.h),

                const SocialLoginButtons(),
                SizedBox(height: 22.h),

                /// GO TO LOGIN
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRouter.loginAccount,
                    ),
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
                            text: "Sign In",
                            style: AppTypography.bodyMediumBold.copyWith(
                              color: AppColors.main500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: 68.h +
                        MediaQuery.of(context).viewPadding.bottom),
              ],
            ),
          ),
        ),
      ),
    );
  }
}