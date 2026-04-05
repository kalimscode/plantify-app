import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class Navigation4 extends StatelessWidget {
  final String? imagePath;
  final String name;
  final String location;
  final VoidCallback? onBellTap;
  final VoidCallback? onHeartTap;

  final VoidCallback? onAvatarTap;
  final VoidCallback? onNameTap;
  final VoidCallback? onLocationTap;

  const Navigation4({
    super.key,
    required this.name,
    required this.location,
    this.imagePath,
    this.onBellTap,
    this.onHeartTap,
    this.onAvatarTap,
    this.onNameTap,
    this.onLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar — tappable → profile screen
                GestureDetector(
                  onTap: onAvatarTap,
                  child: Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: imagePath != null && imagePath!.isNotEmpty
                          ? Image.file(File(imagePath!), fit: BoxFit.cover)
                          : Image.asset(
                        'assets/images/default_avatar.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                // Name + Location column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Name — tappable → profile screen
                      GestureDetector(
                        onTap: onNameTap,
                        child: Text(
                          name,
                          style: AppTypography.bodyMediumBold.copyWith(
                            color: isDark
                                ? AppColors.fontWhite
                                : AppColors.fontBlack,
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),

                      GestureDetector(
                        onTap: onLocationTap,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/SvgIcons/marker-pin-01.svg',
                              width: 17.w,
                              height: 17.w,
                              colorFilter: const ColorFilter.mode(
                                AppColors.fontGrey,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Flexible(
                              child: Text(
                                location.isNotEmpty ? location : 'Add address',
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.bodyNormalMedium.copyWith(
                                  color: AppColors.fontGrey,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onBellTap,
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.fill01
                        : const Color(0xFFF7F7F7),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/SvgIcons/bell-03.svg',
                      width: 22.w,
                      height: 22.h,
                      color: AppColors.main500,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: onHeartTap,
                child: Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.fill01
                        : const Color(0xFFF7F7F7),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/SvgIcons/heart-rounded.svg',
                      width: 22.w,
                      height: 22.w,
                      color: AppColors.main500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}