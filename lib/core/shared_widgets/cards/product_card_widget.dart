import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/theme/app_typography.dart';
import '../../../features/home/presentation/model/product_ui_model.dart';
import '../../theme/app_colors.dart';

class ProductCard extends StatelessWidget {
  final ProductUiModel product;
  final VoidCallback onLikeToggle;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onLikeToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 176.w,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🌿 Image + Background + Heart icon together
          Stack(
            children: [
              // Background shape
              Container(
                width: 176.w,
                height: 215.h,
                decoration: ShapeDecoration(
color: isDark ? AppColors.fill01 : AppColors.fill04,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ),

              // Product image
              Container(
                width: 176.w,
                height: 215.h,
                decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
                  image: product.imagePath.startsWith('http')
                      ? DecorationImage(
                    image: NetworkImage(product.imagePath),
                    fit: BoxFit.contain,
                  )
                      : DecorationImage(
                    image: AssetImage(product.imagePath),
                    fit: BoxFit.contain,
                  ),

    ),
              ),

              // Heart icon (top-right)
              Positioned(
                top: 4.h,
                right: 6.w,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 24.sp,
                  icon: Icon(
                    product.isLiked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: product.isLiked
                        ? AppColors.main500
                        : (isDark
                        ? AppColors.fontWhite
                        : AppColors.fontBlack),
                  ),
                  onPressed: onLikeToggle,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // 🌱 Product details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              SizedBox(
                width: 176.w,
                child: Text(
                  product.title,
                  style: AppTypography.bodyLargeBold.copyWith(
                    color: isDark ? AppColors.fontWhite : Colors.black,

                  )
                ),
              ),
              SizedBox(height: 2.h),

              // Category
              SizedBox(
                width: 176.w,
                child: Text(
                  product.category,
                  style: AppTypography.bodyMediumMedium.copyWith(
                    color: AppColors.fontGrey
                  )
                ),
              ),
              SizedBox(height: 2.h),

              // Price
              SizedBox(
                width: 176.w,
                child: Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: AppTypography.h6Bold.copyWith(
                    color: AppColors.main500
                  )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
