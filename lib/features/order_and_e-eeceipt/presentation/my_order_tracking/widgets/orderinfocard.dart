import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';

class OrderInfoCard extends StatelessWidget {
  const OrderInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
    color: AppColors.fontGrey,
    width: 0.01,
      ),),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: isDark ? AppColors.fill01 : AppColors.fill04,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/SvgIcons/truck-01.svg',
                width: 24.w,
                color: AppColors.main500,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('#434324MX', style: AppTypography.bodyMediumBold.copyWith(
                  color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                )),
                SizedBox(height: 4.h),
                Text(
                  'On Progress',
                  style: AppTypography.bodySmallMedium.copyWith(
                    color: AppColors.main500,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    _InfoColumn(
                      title: 'Estimate delivery',
                      value: '20 feb, 2023',
                      isDark: isDark,
                    ),
                    _InfoColumn(
                      title: 'Shipment',
                      value: 'Kencana Express',
                      isDark: isDark,
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
             Navigator.pushNamed(context, AppRouter.orderlivetracking);
            },
            child: Icon(Icons.chevron_right,color: isDark ? AppColors.fontWhite : AppColors.fontBlack,),
          ),
        ],
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {

  final String title;
  final String value;
final bool isDark;
  const _InfoColumn({
    required this.title,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.bodySmallMedium.copyWith(
            color: AppColors.fontGrey,
          ),
        ),
        SizedBox(height: 4.h),
        Text(value, style: AppTypography.bodySmallBold.copyWith(
          color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
        )),
      ],
    );
  }
}
