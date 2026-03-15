import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {

  /// -------------------- LIGHT THEME --------------------
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: AppTypography.fontFamily,
    scaffoldBackgroundColor: AppColors.white500,
    primaryColor: AppColors.main500,

    colorScheme: const ColorScheme.light(
      primary: AppColors.main500,
      secondary: AppColors.main300,
      background: AppColors.white500,
      surface: AppColors.fill04,
      error: AppColors.danger500,
    ),

    textTheme: TextTheme(
      displayLarge: AppTypography.h1Bold.copyWith(color: AppColors.fontBlack),
      displayMedium: AppTypography.h2Bold.copyWith(color: AppColors.fontBlack),
      displaySmall: AppTypography.h3Bold.copyWith(color: AppColors.fontBlack),
      headlineMedium: AppTypography.h4Bold.copyWith(color: AppColors.fontBlack),
      headlineSmall: AppTypography.h5Bold.copyWith(color: AppColors.fontBlack),
      titleLarge: AppTypography.h6Bold.copyWith(color: AppColors.fontBlack),

      bodyLarge: AppTypography.bodyLargeRegular.copyWith(color: AppColors.fontBlack),
      bodyMedium: AppTypography.bodyMediumRegular.copyWith(color: AppColors.fontBlack),
      bodySmall: AppTypography.bodySmallRegular.copyWith(color: AppColors.fontGrey),
    ),

    iconTheme: const IconThemeData(color: AppColors.fontBlack),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white500,
      foregroundColor: AppColors.fontBlack,
      elevation: 0,
    ),
  );

  /// -------------------- DARK THEME --------------------
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: AppTypography.fontFamily,
    scaffoldBackgroundColor: AppColors.dark500,
    primaryColor: AppColors.main500,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.main500,
      secondary: AppColors.main300,
      background: AppColors.dark500,
      surface: AppColors.fill01,
      error: AppColors.danger400,
    ),

    textTheme: TextTheme(
      displayLarge: AppTypography.h1Bold.copyWith(color: AppColors.fontWhite),
      displayMedium: AppTypography.h2Bold.copyWith(color: AppColors.fontWhite),
      displaySmall: AppTypography.h3Bold.copyWith(color: AppColors.fontWhite),
      headlineMedium: AppTypography.h4Bold.copyWith(color: AppColors.fontWhite),
      headlineSmall: AppTypography.h5Bold.copyWith(color: AppColors.fontWhite),
      titleLarge: AppTypography.h6Bold.copyWith(color: AppColors.fontWhite),

      bodyLarge: AppTypography.bodyLargeRegular.copyWith(color: AppColors.fontWhite),
      bodyMedium: AppTypography.bodyMediumRegular.copyWith(color: AppColors.fontWhite),
      bodySmall: AppTypography.bodySmallRegular.copyWith(color: AppColors.fontGrey),
    ),

    iconTheme: const IconThemeData(color: AppColors.fontWhite),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.dark500,
      foregroundColor: AppColors.fontWhite,
      elevation: 0,
    ),
  );
}