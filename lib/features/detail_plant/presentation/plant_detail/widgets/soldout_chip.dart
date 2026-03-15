import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';


class SoldOutChip extends StatelessWidget {
  final String text;

  const SoldOutChip({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.fill01 : AppColors.fill04,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        text,
        style: AppTypography.bodySmallMedium.copyWith(
          color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
        ),
      ),
    );
  }
}