import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';

enum RadioState { active, nonActive, pressed, disabled }

class CustomRadioButton extends StatelessWidget {
  final bool isActive;
  final bool isPressed;
  final bool isDisabled;
  final VoidCallback? onTap;

  const CustomRadioButton({
    super.key,
    required this.isActive,
    this.isPressed = false,
    this.isDisabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    /// 🔹 PRESSED STATE
    if (isPressed) {
      return SizedBox(
        width: 32.w,
        height: 32.h,
        child: Stack(
          children: [
            Container(
              width: 32.w,
              height: 32.h,
              decoration: const ShapeDecoration(
                color: Color(0xFFECF0ED),
                shape: OvalBorder(),
              ),
            ),
            Center(
              child: Container(
                width: 20.w,
                height: 20.h,
                decoration: const ShapeDecoration(
                  shape: OvalBorder(
                    side: BorderSide(
                      width: 1,
                      color: Color(0xFF41644A),
                    ),
                  ),
                ),
              ),
            ),
            if (isActive)
              Center(
                child: Container(
                  width: 12.w,
                  height: 12.h,
                  decoration: const ShapeDecoration(
                    color: AppColors.main500,
                    shape: OvalBorder(),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    /// 🔹 DISABLED STATE
    if (isDisabled) {
      return SizedBox(
        width: 20.w,
        height: 20.h,
        child: Stack(
          children: [
            Container(
              width: 20.w,
              height: 20.h,
              decoration: ShapeDecoration(
                shape: OvalBorder(
                  side: BorderSide(
                    width: 1,
                    color: AppColors.main500,
                  ),
                ),
              ),
            ),
            if (isActive)
              Center(
                child: Container(
                  width: 12.w,
                  height: 12.h,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFF7F7F7),
                    shape: OvalBorder(),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    /// 🔹 NORMAL STATE
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Stack(
          children: [
            Container(
              width: 20.w,
              height: 20.h,
              decoration: const ShapeDecoration(
                shape: OvalBorder(
                  side: BorderSide(
                    width: 1,
                    color: Color(0xFF41644A),
                  ),
                ),
              ),
            ),
            if (isActive)
              Center(
                child: Container(
                  width: 12.w,
                  height: 12.h,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF41644A),
                    shape: OvalBorder(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}