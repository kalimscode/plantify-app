import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/theme/app_typography.dart';
import '../../../features/home/presentation/model/product_ui_model.dart';
import '../../theme/app_colors.dart';

class ProductCard extends StatelessWidget {
  final ProductUiModel product;
  final VoidCallback onLikeToggle;
  final VoidCallback? onAddToCart;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onLikeToggle,
    this.onAddToCart,
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
          // 🌿 Image + Background + Heart icon + Cart icon
          Stack(
            children: [
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

              if (onAddToCart != null)
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: onAddToCart,
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: AppColors.main500,
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.main500.withOpacity(0.4),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/SvgIcons/shopping-cart-03.svg',
                          width: 17.w,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: 12.h),

          // 🌱 Product details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 176.w,
                child: Text(
                  product.title,
                  style: AppTypography.bodyLargeBold.copyWith(
                    color: isDark ? AppColors.fontWhite : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              SizedBox(
                width: 176.w,
                child: Text(
                  product.category,
                  style: AppTypography.bodyMediumMedium
                      .copyWith(color: AppColors.fontGrey),
                ),
              ),
              SizedBox(height: 2.h),
              SizedBox(
                width: 176.w,
                child: Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style:
                  AppTypography.h6Bold.copyWith(color: AppColors.main500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}