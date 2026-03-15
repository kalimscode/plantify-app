import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/theme/app_colors.dart';

class ToggleSwitch extends StatelessWidget {
  final bool isActive;
  final bool isDarkMode;
  final VoidCallback? onTap;

  const ToggleSwitch({
    super.key,
    required this.isActive,
    this.isDarkMode = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isActive
        ? AppColors.main500
        : isDarkMode
        ? AppColors.fill01
        : AppColors.fill03;

    final circleColor = isActive
        ? Colors.white
        : isDarkMode
        ? AppColors.fontGrey
        : Colors.white;

    final circleLeft = isActive ? 26.w : 2.w;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 48.w,
        height: 23.h,
        child: Stack(
          children: [
            Container(
              width: 48.w,
              height: 23.h,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            // Toggle circle
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              left: circleLeft,
              top: 2.h,
              child: Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: circleColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}