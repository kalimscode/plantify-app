import 'package:flutter/material.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';
import '../input_state/input_state.dart';

class OtpCodeInputStyle {
  final Color backgroundColor;
  final Color? borderColor;
  final Color textColor;
  final TextStyle textStyle;

  OtpCodeInputStyle({
    required this.backgroundColor,
    this.borderColor,
    required this.textColor,
    required this.textStyle,
  });

  static OtpCodeInputStyle getStyle(bool isDark, InputState state) {

    final text= isDark ? AppColors.fontWhite: AppColors.fontBlack;
    switch (state) {
      case InputState.defaultState:
        return OtpCodeInputStyle(
          backgroundColor: isDark ? AppColors.dark500: AppColors.white500,
          textColor: text,
          textStyle: AppTypography.bodyMediumMedium
        );

      case InputState.typing:
        return OtpCodeInputStyle(
          backgroundColor: isDark ? AppColors.dark500: AppColors.white500,
          textColor: text,
          textStyle: AppTypography.bodyMediumMedium,
        );

      case InputState.filled:
        return OtpCodeInputStyle(
          backgroundColor: isDark ? AppColors.dark500: AppColors.white500,
          textColor: text,
          textStyle:AppTypography.bodyMediumMedium
        );
    }
  }
}
