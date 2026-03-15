import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/shared_widgets/action_buttons/action_button.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';



class LeaveReviewSheet extends StatelessWidget {
  const LeaveReviewSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DraggableScrollableSheet(
      initialChildSize: 0.50,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
          bottom: 48,
        ),
        decoration:  ShapeDecoration(
          color: isDark ? AppColors.dark500 : AppColors.white500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
        ),

        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text(
                'Leave a Review',
                textAlign: TextAlign.center,
                style: AppTypography.h5Bold.copyWith(
                  color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                ),
              ),

               SizedBox(height: 24.h),

              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [

                    Row(
                      children: [

                        Container(
                          width: 120.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            color: isDark? AppColors.fill01:AppColors.fill04,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/plant1.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        SizedBox(width: 12.w),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                'Variegated snake',
                                style: AppTypography.bodyLargeBold.copyWith(
                                  color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                                )

                                  ),
                              SizedBox(height: 4.h),

                              Text(
                                'Size: Medium',
                                style: AppTypography.bodyNormalRegular.copyWith(
                                  color: AppColors.fontGrey
                                )
                              ),

                              SizedBox(height: 2.h),

                              Text(
                                'Qty: 1',
                                style: AppTypography.bodyNormalRegular.copyWith(
                                  color: AppColors.fontGrey),
                                ),
                              SizedBox(height: 2.h),

                              Text(
                                '\$20.00',
                                style: AppTypography.h6Bold.copyWith(
                                  color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                                )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                     SizedBox(height: 12.h),

                    Row(
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 24.w),
                          child: SvgPicture.asset(
                            'assets/SvgIcons/Star.svg',
                            color: index < 4
                                ? AppColors.main500
                                : AppColors.fontGrey,
                            width: 20.w,
                            height: 20.w,
                          ),
                        );
                      }),
                    ),

                     SizedBox(height: 12.h),

                    SizedBox(
                      width: 356.w,
                      child: Text(
                        'Very good product and fast delivery',
                        style: AppTypography.bodyMediumRegular.copyWith(
                          color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                        )
                      ),
                    ),
                  ],
                ),
              ),

               SizedBox(height: 24.h),

            Row(
                children: [

                  Expanded(
                    child: ActionButton(text: 'Cancel',
                      onPressed: () => Navigator.pop(context),
variant: ButtonVariant.line,size: ButtonSize.medium,
                    )
                  ),

                   SizedBox(width: 16.w),

                  Expanded(
                    child: ActionButton(text: 'Submit',
    onPressed: () {
      Navigator.pop(context);
    }
                    )
                    ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}