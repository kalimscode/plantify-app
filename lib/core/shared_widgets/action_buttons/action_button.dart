import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';

enum ButtonVariant { primary, secondary, line }
enum ButtonState { normal, disabled }
enum ButtonSize { full, medium }

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonState state;
  final ButtonSize size;

  const ActionButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.state = ButtonState.normal,
    this.size = ButtonSize.full,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = state == ButtonState.disabled;

    final width = size == ButtonSize.full ? 380.w : 160.w;
    final textColor = _getTextColor();
    final bgColor = _getBackgroundColor();
    final border = _getBorder();

    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        width: width,
        height: 56.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: ShapeDecoration(
          color: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: border ?? BorderSide.none,
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppTypography.bodyMediumBold.copyWith(
              color: textColor
            )
          ),
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
