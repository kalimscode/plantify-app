import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SocialButton(
          icon: 'assets/SvgIcons/google.svg',
          label: 'Sign in with Google',
        ),
        SizedBox(height: 24.h),
        _SocialButton(
          icon: 'assets/SvgIcons/apple.svg',
          label: 'Sign in with Apple',
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final bool isDark;
  final String icon;
  final String label;

  const _SocialButton({
    Key? key,
    required this.icon,
    required this.label,
    this.isDark = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;


    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2.w,
            color: isDark? AppColors.fill01: AppColors.fill04,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center, // ✅ Centered
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 32.w,
            height: 32.w,
          ),
          SizedBox(
            width: 320.w,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: AppTypography.bodyMediumMedium.copyWith(
                color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
