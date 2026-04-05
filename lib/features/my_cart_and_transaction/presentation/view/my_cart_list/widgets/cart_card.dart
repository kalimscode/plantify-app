import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_typography.dart';

class CartCard extends StatelessWidget {
  final String title;
  final double price;
  final String size;
  final int quantity;
  final String image;
  final VoidCallback? onDelete;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartCard({
    super.key,
    required this.title,
    required this.price,
    required this.size,
    required this.quantity,
    required this.image,
    this.onDelete,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
color: isDark ? AppColors.fill01 : AppColors.fill04,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child:image.startsWith("http")
                ? Image.network(image, fit: BoxFit.contain)
                : Image.asset(image, fit: BoxFit.contain)
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 190.w,
                  child: Text(
                    title,
                    style: AppTypography.bodyLargeBold.copyWith(
                      color: isDark
                          ? AppColors.fontWhite
                          : AppColors.fontBlack,
                    ),
                  ),
                ),

                SizedBox(height: 12.h),

                SizedBox(
                  width: 222.w,
                  child: Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: AppTypography.bodyMediumBold.copyWith(
                      color: isDark
                          ? AppColors.fontWhite
                          : AppColors.fontBlack,
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  'Size: $size',
                  style: AppTypography.bodyNormalRegular.copyWith(
                    color: AppColors.fontGrey,
                  ),
                ),

                SizedBox(height: 16.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /// Quantity
                    SizedBox(
                      width: 120.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: onIncrease,
                            child: SvgPicture.asset(
                              'assets/SvgIcons/plus-square.svg',
                              width: 24.w,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          SizedBox(
                            width: 48.w,
                            child: Text(
                              quantity.toString(),
                              textAlign: TextAlign.center,
                              style: AppTypography.bodyMediumBold.copyWith(
                                color: isDark
                                    ? AppColors.fontWhite
                                    : AppColors.fontBlack,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          GestureDetector(
                            onTap: onDecrease,
                            child: SvgPicture.asset(
                              'assets/SvgIcons/minus-square.svg',
                              width: 24.w,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 12.w),

                    SizedBox(
                      width: 84.w,
                      child: Text(
                        '\$${(price * quantity).toStringAsFixed(2)}',
                        textAlign: TextAlign.center,
                        style: AppTypography.h6Bold.copyWith(
                          color: AppColors.main500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
