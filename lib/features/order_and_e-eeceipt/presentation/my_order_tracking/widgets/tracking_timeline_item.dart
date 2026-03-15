import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared_widgets/action_buttons/radio_button.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';


class TrackingTimelineItem extends StatelessWidget {
  final bool isActive;
  final bool isLast;

  const TrackingTimelineItem({
    super.key,
    this.isActive = true,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CustomRadioButton(
                isActive: isActive,
              ),
              if (!isLast)
                Container(
                  margin: EdgeInsets.only(top: 6.h),
                  width: 1,
                  height: 46.h,
                  color: AppColors.main500,
                ),
            ],
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        'Order In Transit, March 12',
                        style: AppTypography.bodyMediumBold.copyWith(
                          color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                        ),
                      ),
                    ),
                    Text(
                      '13.20PM',
                      style: AppTypography.bodySmallMedium.copyWith(
                        color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  'Plum Street, San Francisco, California 93244',
                  style: AppTypography.bodySmallMedium.copyWith(
                    color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
