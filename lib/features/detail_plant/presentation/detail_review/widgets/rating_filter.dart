import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';


class RatingFilterWidget extends StatelessWidget {
  final int selectedRating;
  final ValueChanged<int> onChanged;

  const RatingFilterWidget({
    super.key,
    required this.selectedRating,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 38.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        children: [
          _Chip('All', selectedRating == 0, () => onChanged(0)),
          for (int i = 5; i >= 1; i--)
            _Chip('$i', selectedRating == i, () => onChanged(i)),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _Chip(this.title, this.selected, this.onTap);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90.w,
        height: 38.h,
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: selected ? AppColors.main500 : (isDark ? AppColors.fill01 : AppColors.fill04),
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/SvgIcons/Star.svg',
              width: 16.w,
              height: 16.h,
              colorFilter: ColorFilter.mode(
                selected ? AppColors.white500 : AppColors.main500,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: AppTypography.bodyMediumMedium.copyWith(
                color:
                selected ? AppColors.white500 : (isDark ? AppColors.fontWhite : AppColors.fontBlack)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
