import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';

class PlantCategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const PlantCategoryButton({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final Color activeColor = AppColors.main500; // Green accent
    final Color borderColor = isDark ? AppColors.fill01 : AppColors.fill04;
    final Color textColor = isSelected
        ? AppColors.fontWhite
        : (isDark ? AppColors.fontWhite : AppColors.fontBlack);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: isSelected
              ? null
              : Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.bodyMediumMedium.copyWith(
            color: textColor
          )
        ),
      ),
    );
  }
}
