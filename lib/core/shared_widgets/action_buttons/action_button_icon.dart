import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/theme/app_typography.dart';
import '../../theme/app_colors.dart';
import 'action_button.dart';

class ActionButtonIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonState state;
  final ButtonSize size;

  const ActionButtonIcon({
    super.key,
    required this.text,
    required this.icon,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.state = ButtonState.normal,
    this.size = ButtonSize.full,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = state == ButtonState.disabled;
    final width = size == ButtonSize.full ? 380.0 : 160.0;
    final bgColor = _getBackgroundColor();
    final textColor = _getTextColor();
    final border = _getBorder();

    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        width: width,
        height: 56.h,
        padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
        decoration: ShapeDecoration(
          color: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: border ?? BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 20.sp),
            const SizedBox(width: 10),
            Text(
              text,
              style: AppTypography.bodyMediumBold.copyWith(
                color: textColor
              )
            ),
          ],
        ),
      ),
    );
  }


  Color? _getBackgroundColor() {
    if (state == ButtonState.disabled) return AppColors.fill04;
    switch (variant) {
      case ButtonVariant.primary:
        return  AppColors.main500;
      case ButtonVariant.secondary:
        return AppColors.main100;
      case ButtonVariant.line:
        return Colors.transparent;
    }
  }

  Color _getTextColor() {
    if (state == ButtonState.disabled) return AppColors.fill04;
    switch (variant) {
      case ButtonVariant.primary:
        return AppColors.fontWhite;
      case ButtonVariant.secondary:
        return AppColors.main500;
      case ButtonVariant.line:
        return AppColors.main500;
    }
  }

  BorderSide? _getBorder() {
    if (variant == ButtonVariant.line) {
      return BorderSide(
        width: 1.w,
        color: state == ButtonState.disabled
            ? AppColors.main100
            : AppColors.main500,
      );
    }
    return null;
  }
}
