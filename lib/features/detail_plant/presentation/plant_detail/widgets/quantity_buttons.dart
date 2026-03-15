import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/app_colors.dart';

class QtyButton extends StatelessWidget {

  final String icon;
  final VoidCallback onTap;

  const QtyButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
        icon,
        width: 28.w,
      ),
    );
  }
}