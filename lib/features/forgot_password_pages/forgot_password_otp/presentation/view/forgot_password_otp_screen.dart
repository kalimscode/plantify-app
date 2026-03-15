import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/shared_widgets/action_buttons/action_button.dart';
import '../../../../../core/shared_widgets/navigation/navigation1.dart';
import '../../../../../core/di/providers.dart';
import '../../../../../router.dart';

class ForgotPasswordOtpScreen extends ConsumerStatefulWidget {
  const ForgotPasswordOtpScreen({super.key});

  @override
  ConsumerState<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState
    extends ConsumerState<ForgotPasswordOtpScreen> {

  String email = "";

  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());

  final List<FocusNode> _focusNodes =
  List.generate(4, (_) => FocusNode());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is String) {
      email = args;
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }

    for (var f in _focusNodes) {
      f.dispose();
    }

    super.dispose();
  }

  void _onChanged(int index, String value) {
    final notifier = ref.read(forgotPasswordOtpProvider.notifier);

    notifier.updateOtpDigit(index, value);

    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Widget _otpBox(int index, bool isDark) {
    return Container(
      width: 64.w,
      height: 64.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDark ? AppColors.fill01 : AppColors.fill04,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? AppColors.fill01 : AppColors.fill04,
          width: 1.w,
        ),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: AppTypography.h4Bold.copyWith(
          color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
        ),
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
        onChanged: (v) => _onChanged(index, v),
      ),
    );
  }

  void _resetOtp() {
    for (var c in _controllers) {
      c.clear();
    }

    ref.read(forgotPasswordOtpProvider.notifier).resetOtp();
    _focusNodes.first.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPasswordOtpProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Navigation1(title: 'Enter Otp Code'),

              SizedBox(height: 32.h),

              
              Center(
                child: Text(
                  "A 4 digit code has been sent to",
                  style: AppTypography.bodyLargeRegular.copyWith(
                    color:
                    isDark ? AppColors.fontWhite : AppColors.fontBlack,
                  ),
                ),
              ),

              SizedBox(height: 4.h),

              Center(
                child: Text(
                  email,
                  style: AppTypography.bodyLargeRegular.copyWith(
                    color: AppColors.main500,
                  ),
                ),
              ),

              SizedBox(height: 48.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  4,
                      (index) => _otpBox(index, isDark),
                ),
              ),

              SizedBox(height: 48.h),

          Row(
            children: [
              Expanded(
                child: ActionButton(
                  text: "Reset",
                  variant: ButtonVariant.line,
                  size: ButtonSize.medium,
                  onPressed: _resetOtp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: ActionButton(
                  text: "Continue",
                  variant: ButtonVariant.primary,
                  size: ButtonSize.medium,
                  onPressed: state.isCompleted
                      ? () async {
                    await ref
                        .read(forgotPasswordOtpProvider.notifier)
                        .verifyOtp();

                    if (!mounted) return;
                    Navigator.pushNamed(context, AppRouter.newPassword);
                  }
                      : null,
                ),
              ),
            ],
          ),
      ]  ),
      ),
    ));
  }
}