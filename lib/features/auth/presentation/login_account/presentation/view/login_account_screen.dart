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

class LoginAccountScreen extends ConsumerStatefulWidget {
  const LoginAccountScreen({super.key});

  @override
  ConsumerState<LoginAccountScreen> createState() =>
      _LoginAccountScreenState();
}

class _LoginAccountScreenState
    extends ConsumerState<LoginAccountScreen> {

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(loginAccountViewModelProvider);
    final viewModel = ref.read(loginAccountViewModelProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding:
          EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login Your\nAccount',
                style: AppTypography.h4Bold.copyWith(
                  color: isDark
                      ? AppColors.fontWhite
                      : AppColors.fontBlack,
                ),
              ),
              SizedBox(height: 30.h),

              /// Email
              AppInputField(
                label: "Email",
                hintText: "example@yourdomain.com",
                leadingIconPath: "assets/SvgIcons/mail-02.svg",
                keyboardType: TextInputType.emailAddress,
                controller: TextEditingController(text: state.email)
                  ..selection = TextSelection.collapsed(
                    offset: state.email.length,
                  ),
                onChanged: viewModel.updateEmail,
              ),
              SizedBox(height: 22.h),

              /// Password
              AppInputField(
                label: "Password",
                hintText: "Typing your password",
                leadingIconPath: "assets/SvgIcons/lock-01.svg",
                isPassword: true,
                controller: TextEditingController(text: state.password)
                  ..selection = TextSelection.collapsed(
                    offset: state.password.length,
                  ),
                onChanged: viewModel.updatePassword,
              ),
              SizedBox(height: 22.h),

              /// Remember Me
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ActionCheckbox(
                        value: state.rememberMe,
                        onChanged: viewModel.toggleRememberMe,
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
                    onTap: () =>
                        Navigator.pushNamed(context, AppRouter.forgotPassword),
                    child: Text(
                      'Forgot Password',
                      style: AppTypography.bodySmallBold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22.h),

              /// ✅ SIGN IN BUTTON (STATE-DRIVEN)
              ActionButton(
                text: state.isLoading ? "Signing In..." : "Sign In",
                onPressed: state.isFormValid && !state.isLoading
                    ? () async {
                  final success = await viewModel.login();

                  if (!mounted) return;

                  if (success) {

    AppSnackBar.show(
    context,
    message: "Login successful",
    type: SnackBarType.success,
    );

    Future.delayed(const Duration(milliseconds: 600), () {
    Navigator.pushReplacementNamed(
    context,
    AppRouter.mainWrapper,
    );
    });

                  } else if (state.errorMessage != null) {
                    AppSnackBar.show(
                      context,
                      message: state.errorMessage!,
                      type: SnackBarType.error,

                    );
                  }
                }
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

              /// Go to Sign Up
              Center(
                child: GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, AppRouter.createAccount),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Don’t have an account? ",
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
              SizedBox(height: 175.h + MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
