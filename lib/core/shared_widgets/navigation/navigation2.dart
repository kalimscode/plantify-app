import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/theme/app_typography.dart';

import '../../theme/app_colors.dart';

class Navigation2 extends StatelessWidget {
  final String title;
  final String leadingIconPath;
  final String trailingIconPath;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onTrailingTap;

  const Navigation2({
    Key? key,
    required this.title,
    required this.leadingIconPath,
    required this.trailingIconPath,
    this.onLeadingTap,
    this.onTrailingTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.fontWhite: AppColors.fontBlack;

    return Container(
      width: 380.w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onLeadingTap,
            child: SvgPicture.asset(
              leadingIconPath,
              width: 24.w,
              height: 24.h,
              color: textColor,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: AppTypography.h5Bold.copyWith(
                  color: textColor
                )
              ),
            ),
          ),
          GestureDetector(
            onTap: onTrailingTap,
            child: SvgPicture.asset(
              trailingIconPath,
              width: 24.w,
              height: 24.h,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
