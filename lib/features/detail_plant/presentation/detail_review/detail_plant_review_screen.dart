import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/features/detail_plant/presentation/detail_review/widgets/rating_filter.dart';
import 'package:plantify/features/detail_plant/presentation/detail_review/widgets/review_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class DetailPlantReviewScreen extends StatefulWidget {
  const DetailPlantReviewScreen({super.key});

  @override
  State<DetailPlantReviewScreen> createState() =>
      _DetailPlantReviewScreenState();
}

class _DetailPlantReviewScreenState extends State<DetailPlantReviewScreen> {
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 32.h),
        child: Column(
          children: [
            SafeArea(
              bottom: false,
              child: Container(
                height: 62.h,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: SvgPicture.asset(
                          'assets/SvgIcons/arrow-narrow-left.svg',
                          colorFilter:  ColorFilter.mode(
                            isDark ? AppColors.fontWhite : AppColors.fontBlack,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 12.w),

                    Text(
                      '4.8 ( 5342 Review )',
                      style: AppTypography.h5Bold.copyWith(
                        color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                      ),
                    ),

                    const Spacer(),

                    SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: SvgPicture.asset(
                        'assets/SvgIcons/other.svg',
                        colorFilter:  ColorFilter.mode(
                          isDark ? AppColors.fontWhite : AppColors.fontBlack,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: RatingFilterWidget(
                        selectedRating: _selectedRating,
                        onChanged: (v) => setState(() => _selectedRating = v),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    ListView.separated(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      separatorBuilder: (_, __) => SizedBox(height: 24.h),
                      itemBuilder: (_, __) => const ReviewCard(
                        userName: 'Antony Lukas',
                        timeAgo: '2 days ago',
                        reviewText:
                        'Always top notch on there order process. Gives quality plants and always handle shipments pretty well. I do love ordering rare plants with them. Been partner with them for 2 years now and I will always order my collection trough them. Thank you so much!',
                        rating: '5.0',
                        likeCount: '10K',
                        dislikeCount: '12',
                      ),
                    ),
                  ],
                ),
              ),
            ),
         SizedBox(height: 30.h,) ],
        ),
      ),
    );
  }
}