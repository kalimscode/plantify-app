import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/app_colors.dart';


class TrackingSteps extends StatelessWidget {
  const TrackingSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              StepIcon(icon: 'assets/SvgIcons/package.svg'),
              SizedBox(width: 46),
              StepIcon(icon: 'assets/SvgIcons/truck-01.svg'),
              SizedBox(width: 46),
              StepIcon(icon: 'assets/SvgIcons/package.svg'),
              SizedBox(width: 46),
              StepIcon(
                icon: 'assets/SvgIcons/package.svg',
                inactive: true,
              ),
            ],
          ),

          SizedBox(height: 20.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              StepCheck(active: true),
              StepMiniLine(),
              StepCheck(active: true),
              StepMiniLine(),
              StepCheck(active: true),
              StepMiniLine(),
              StepCheck(active: false),
            ],
          ),
        ],
      ),
    );
  }
}

class StepIcon extends StatelessWidget {
  final String icon;
  final bool inactive;

  const StepIcon({
    super.key,
    required this.icon,
    this.inactive = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      height: 40.h,
      child: Center(
        child: SvgPicture.asset(
          icon,
          width: 24.w,
          color: inactive
              ? AppColors.fontGrey
              : AppColors.main500,
        ),
      ),
    );
  }
}

class StepCheck extends StatelessWidget {
  final bool active;

  const StepCheck({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 20.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? AppColors.main500 : AppColors.fill04,
      ),
      child: Icon(Icons.check, color: active ? AppColors.white500 : AppColors.fontGrey, size: 16.sp,)
    );
  }
}

class StepMiniLine extends StatelessWidget {
  const StepMiniLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.w,
      height: 2.h,
      color: AppColors.main500,
    );
  }
}
