import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';

class Navigation1 extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const Navigation1({
    Key? key,
    required this.title,
    this.onBackPressed,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.fontWhite: AppColors.fontBlack;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Back Arrow Icon
          GestureDetector(
            onTap: onBackPressed ?? () => Navigator.pop(context),
            child: SvgPicture.asset(
              'assets/SvgIcons/arrow-narrow-left.svg',
              width: 24.w,
              height: 24.h,
              color: textColor,
            ),
          ),
           SizedBox(width: 12.w),

          // Title Text
          Expanded(
            child: Text(
              title,
              style: AppTypography.h5Bold.copyWith(
                color: textColor,
              )
            ),
          ),
        ],
      ),
    );
  }
}
