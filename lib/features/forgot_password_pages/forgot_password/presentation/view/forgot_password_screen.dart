import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';
import 'package:plantify/core/shared_widgets/action_buttons/action_button.dart';
import '../../../../../core/di/providers.dart';
import '../../../../../core/shared_widgets/form_fields/app_input_field/app_input_field.dart';
import '../../../../../core/shared_widgets/navigation/navigation1.dart';
import '../../../../../router.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(forgotPasswordProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Navigation1(title: ''),
              SizedBox(height: 32.h),

              Text(
                'Forgot\nPassword',
                style: AppTypography.h4Bold.copyWith(
                  color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                  height: 1.22.h,
                ),
              ),
              SizedBox(height: 32.h),

              Text(
                "Don't worry! It happens. Please enter the email associated with your account.",
                style: AppTypography.bodyLargeRegular.copyWith(
                  color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                  height: 1.4.h,
                ),
              ),
              SizedBox(height: 98.h),

              AppInputField(
                label: 'Email/Mobile Number',
                hintText: 'Enter your email or phone number',
                controller: _emailController,
                onChanged: notifier.updateEmailOrPhone,
              ),
              SizedBox(height: 24.h),

              ActionButton(
                text: "Submit",
                onPressed: () async {
                  final email = _emailController.text.trim();
                  if (email.isEmpty) return;

                  await notifier.submit();

                  if (!mounted) return;

                  Navigator.pushNamed(
                    context,
                    AppRouter.forgotPasswordOtp,
                    arguments: email,
                  );
                },
                variant: ButtonVariant.primary,
              ),
              SizedBox(height: 98.h),

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
              SizedBox(height: 264.h),
            ],
          ),
        ),
      ),
    );
  }
}