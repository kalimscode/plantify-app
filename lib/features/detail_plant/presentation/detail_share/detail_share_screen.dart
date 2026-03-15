import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class DetailShareScreen extends StatelessWidget {
  const DetailShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
color: isDark? AppColors.dark500: AppColors.white500,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),

      constraints: BoxConstraints(
        minHeight: 460.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Share',
                    style: AppTypography.bodyLargeBold.copyWith(
                      color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                    )
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child:  Icon(Icons.close, size: 24,color: isDark ? AppColors.fontWhite : AppColors.fontBlack ),
                ),
              ],
            ),

            SizedBox(height: 32.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _ShareItem(icon: 'whatsapp', label: 'WhatsApp'),
                _ShareItem(icon: 'twitter', label: 'Twitter'),
                _ShareItem(icon: 'instagram', label: 'Instagram'),
                _ShareItem(icon: 'facebook', label: 'Facebook'),
              ],
            ),

            SizedBox(height: 32.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _ShareItem(icon: 'send-01', label: 'Telegram'),
                _ShareItem(icon: 'message-dots-circle', label: 'Message'),
                _ShareItem(icon: 'mail-02', label: 'Email'),
                _ShareItem(icon: 'other', label: 'Other'),
              ],
            ),

            SizedBox(height: 32.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              decoration: BoxDecoration(
                color:  isDark ? AppColors.fill01 : AppColors.fill04,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Copy Link',
                      style: AppTypography.bodyMediumMedium.copyWith(
                        color: AppColors.fontGrey
                      )
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/SvgIcons/copy-06.svg',
                    width: 24.w,
                    colorFilter: ColorFilter.mode(
                      AppColors.main500,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}

class _ShareItem extends StatelessWidget {
  final String icon;
  final String label;

  const _ShareItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Container(
          width: 64.w,
          height: 64.w,
          decoration: BoxDecoration(
            color: isDark ? AppColors.fill01 : AppColors.fill04,
            borderRadius: BorderRadius.circular(16.r),
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/SvgIcons/$icon.svg',
            width: 32.w,
            colorFilter: ColorFilter.mode(
              AppColors.main500,
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 64.w,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppTypography.bodyNormalRegular.copyWith(
              color: isDark ? AppColors.fontWhite : AppColors.fontBlack
            )
          ),
        ),
      ],
    );
  }
}
