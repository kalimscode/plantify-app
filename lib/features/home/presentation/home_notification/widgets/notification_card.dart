import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';

class NotificationCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;

  const NotificationCard({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
color: isDark ? AppColors.fill01 : AppColors.fill04
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 64.w,
            height: 68.h,
            decoration: ShapeDecoration(
              color: isDark ? AppColors.fill01 : AppColors.fill04,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 30.w,
                height: 30.h,
                colorFilter: ColorFilter.mode(
                  isDark ? AppColors.fill03 : AppColors.fill01,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyNormalBold.copyWith(
                    color: isDark ? AppColors.fontWhite : AppColors.fontBlack
                  )

                ),
                SizedBox(height: 8.h),
                Text(
                  description,
                  style: AppTypography.bodySmallRegular.copyWith(
                    color: AppColors.fontGrey
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
