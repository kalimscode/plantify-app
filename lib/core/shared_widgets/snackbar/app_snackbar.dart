import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

enum SnackBarType {
  success,
  error,
  warning,
  info,
}

class AppSnackBar {

  static void show(
      BuildContext context, {
        required String message,
        SnackBarType type = SnackBarType.error,
      }) {

    final config = _config(type);

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      ),
      duration: const Duration(seconds: 3),
      content: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 14.h,
        ),
        decoration: BoxDecoration(
          color: config.color,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [

            /// ICON
            Icon(
              config.icon,
              color: AppColors.fontWhite,
              size: 22.sp,
            ),

            SizedBox(width: 12.w),

            /// MESSAGE
            Expanded(
              child: Text(
                message,
                style: AppTypography.bodyMediumMedium.copyWith(
                  color: AppColors.fontWhite,
                ),
              ),
            ),

            /// CLOSE BUTTON
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: Icon(
                Icons.close_rounded,
                color: AppColors.fontWhite,
                size: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static _SnackBarConfig _config(SnackBarType type) {
    switch (type) {

      case SnackBarType.success:
        return _SnackBarConfig(
          color: AppColors.success500,
          icon: Icons.check_circle_rounded,
        );

      case SnackBarType.warning:
        return _SnackBarConfig(
          color: AppColors.warning500,
          icon: Icons.warning_amber_rounded,
        );

      case SnackBarType.info:
        return _SnackBarConfig(
          color: AppColors.info500,
          icon: Icons.info_outline_rounded,
        );

      case SnackBarType.error:
      default:
        return _SnackBarConfig(
          color: AppColors.danger500,
          icon: Icons.error_outline_rounded,
        );
    }
  }
}

class _SnackBarConfig {
  final Color color;
  final IconData icon;

  const _SnackBarConfig({
    required this.color,
    required this.icon,
  });
}