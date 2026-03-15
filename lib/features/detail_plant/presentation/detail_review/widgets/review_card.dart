import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';


class ReviewCard extends StatelessWidget {
  final String userName;
  final String timeAgo;
  final String reviewText;
  final String rating;
  final String likeCount;
  final String dislikeCount;

  const ReviewCard({
    super.key,
    required this.userName,
    required this.timeAgo,
    required this.reviewText,
    required this.rating,
    required this.likeCount,
    required this.dislikeCount,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.fill01: AppColors.fill04,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundImage:
                const AssetImage('assets/images/Avatar1.png'),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName,
                        style: AppTypography.bodyMediumBold.copyWith(
                          color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                        )),
                    SizedBox(height: 4.h),
                    Text(
                      timeAgo,
                      style: AppTypography.bodySmallRegular.copyWith(
                        color: AppColors.fontGrey,
                      ),
                    ),
                  ],
                ),
              ),
              _RatingBadge(rating),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            reviewText,
            style: AppTypography.bodyNormalRegular.copyWith(
              color: AppColors.fontGrey,
              height: 1.5.h,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _Reaction('assets/SvgIcons/like.svg', likeCount),
              SizedBox(width: 20.w),
              _Reaction('assets/SvgIcons/unlike.svg', dislikeCount),
              const Spacer(),
              SvgPicture.asset(
                'assets/SvgIcons/share-06.svg',
                width: 20.w,
                colorFilter: const ColorFilter.mode(
                  AppColors.fontGrey,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),],
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  final String rating;
  const _RatingBadge(this.rating);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.fill01 : AppColors.fill04,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/SvgIcons/Star.svg',
            width: 14.w,
            colorFilter: const ColorFilter.mode(
              AppColors.main500,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            rating,
            style: AppTypography.bodySmallBold.copyWith(
              color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
            ),
          ),
        ],
      ),
    );
  }
}

class _Reaction extends StatelessWidget {
  final String icon;
  final String value;

  const _Reaction(this.icon, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon, width: 18.w),
        SizedBox(width: 6.w),
        Text(
          value,
          style: AppTypography.bodySmallMedium.copyWith(
            color: AppColors.fontGrey,
          ),
        ),
      ],
    );
  }
}
