import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/theme/app_typography.dart';

import '../../theme/app_colors.dart';

class Navigation3 extends StatelessWidget {
  final String title;
  final String leadingIconPath;
  final String trailingIconPath1;
  final String trailingIconPath2;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onTrailing1Tap;
  final VoidCallback? onTrailing2Tap;

  const Navigation3({
    Key? key,
    required this.title,
    required this.leadingIconPath,
    required this.trailingIconPath1,
    required this.trailingIconPath2,
    this.onLeadingTap,
    this.onTrailing1Tap,
    this.onTrailing2Tap,
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
          // Leading Icon
          GestureDetector(
            onTap: onLeadingTap,
            child: SvgPicture.asset(
              leadingIconPath,
              width: 24.w,
              height: 24.h,
              color: textColor,
            ),
          ),

          // Title
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

          // Trailing Icons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onTrailing1Tap,
                child: SvgPicture.asset(
                  trailingIconPath1,
                  width: 24.w,
                  height: 24.h,
                  color: textColor,
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: onTrailing2Tap,
                child: SvgPicture.asset(
                  trailingIconPath2,
                  width: 24.w,
                  height: 24.h,
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
