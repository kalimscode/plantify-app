import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';


class DetailItem extends StatelessWidget {

  final String title;
  final String value;

  const DetailItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Text(
          title,
          style: AppTypography.bodySmallMedium.copyWith(
            color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          value,
          style: AppTypography.bodyMediumBold.copyWith(
            color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
          ),
        ),
      ],
    );
  }
}