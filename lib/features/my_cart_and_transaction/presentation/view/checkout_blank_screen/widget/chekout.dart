import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_typography.dart';


class CheckoutItemWidget extends StatelessWidget {
  final String image;
  final String title;
  final String size;
  final double price;
  final int quantity;
  final bool isDark;

  const CheckoutItemWidget({
    super.key,
    required this.image,
    required this.title,
    required this.size,
    required this.price,
    required this.quantity,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
       border: Border.all(
         color: AppColors.fontGrey,
         width: 0.01,
       )
      ),
      child: Row(
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
color: isDark ? AppColors.fill01 : AppColors.fill04,
              borderRadius: BorderRadius.circular(12),
            ),
            child: image.startsWith("http")
                ? Image.network(image, fit: BoxFit.contain)
                : Image.asset(image, fit: BoxFit.contain),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.bodyMediumBold.copyWith(
                color:    isDark ? AppColors.fontWhite : AppColors.fontBlack,
                )),

                SizedBox(height: 4.h),

                Text(
                  'Size: $size',
                  style: AppTypography.bodySmallRegular.copyWith(
                    color: AppColors.fontGrey,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: AppTypography.bodyLargeBold.copyWith(
                    color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                  )
                ),
              ],
            ),
          ),

          Container(
            width: 24.w,
            height: 24.w,
            decoration: const BoxDecoration(
              color: AppColors.main500,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                quantity.toString(),
                style: AppTypography.bodySmallBold.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}