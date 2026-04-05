import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/shared_widgets/navigation/navigation3.dart';
import 'package:plantify/features/detail_plant/presentation/plant_detail/widgets/item_detail.dart';
import 'package:plantify/features/detail_plant/presentation/plant_detail/widgets/quantity_buttons.dart';
import 'package:plantify/features/detail_plant/presentation/plant_detail/widgets/soldout_chip.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../router.dart';
import '../../../home/presentation/model/product_ui_model.dart';
import '../detail_share/detail_share_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlantDetailScreen extends ConsumerStatefulWidget {
  final ProductUiModel product;

  const PlantDetailScreen({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends ConsumerState<PlantDetailScreen> {
  int quantity = 1;
  bool _addingToCart = false;
  bool _buyingNow = false;

  void _openShareSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.65),
      isScrollControlled: true,
      builder: (_) => const DetailShareScreen(),
    );
  }

  Future<void> _addToCart() async {
    if (_addingToCart) return;
    setState(() => _addingToCart = true);

    final notifier = ref.read(cartProvider.notifier);
    await notifier.addToCart(widget.product, quantity);
    await notifier.loadCart();

    setState(() => _addingToCart = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            '${quantity}x ${widget.product.title} added to cart'),
        backgroundColor: AppColors.main500,
        duration: const Duration(seconds: 1),
      ));
    }
  }

  Future<void> _buyNow() async {
    if (_buyingNow) return;
    setState(() => _buyingNow = true);

    final notifier = ref.read(cartProvider.notifier);

    await notifier.clearCart();

    await notifier.addToCart(widget.product, quantity);
    await notifier.loadCart();

    setState(() => _buyingNow = false);

    if (mounted) {
      Navigator.pushNamed(context, AppRouter.checkoutBlankFullScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final product = widget.product;

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Navigation3(
                title: product.title,
                leadingIconPath: 'assets/SvgIcons/arrow-narrow-left.svg',
                onLeadingTap: () => Navigator.pop(context),
                trailingIconPath1: 'assets/SvgIcons/heart-rounded.svg',
                onTrailing1Tap: () =>
                    Navigator.pushNamed(context, AppRouter.favoriteplantscreen),
                trailingIconPath2: 'assets/SvgIcons/share-06.svg',
                onTrailing2Tap: _openShareSheet,
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image — UNCHANGED
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          product.imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.title,
                            style: AppTypography.h5Bold.copyWith(
                              color: isDark
                                  ? AppColors.fontWhite
                                  : AppColors.fontBlack,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, AppRouter.myCartList),
                          child: SvgPicture.asset(
                            "assets/SvgIcons/shopping-cart-03.svg",
                            width: 24.w,
                            colorFilter: ColorFilter.mode(
                              isDark
                                  ? AppColors.fontWhite
                                  : AppColors.fontBlack,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    Row(
                      children: [
                        SoldOutChip(text: "745 Sold"),
                        SizedBox(width: 12.w),
                        SvgPicture.asset("assets/SvgIcons/Star.svg",
                            width: 16.w),
                        SizedBox(width: 6.w),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, AppRouter.detailreview),
                          child: Text(
                            "4.7 (3242 Review)",
                            style: AppTypography.bodySmallMedium.copyWith(
                              color: isDark
                                  ? AppColors.fontWhite
                                  : AppColors.fontBlack,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 35.h),

                    Text(
                      "Description",
                      style: AppTypography.bodyLargeBold.copyWith(
                        color:
                        isDark ? AppColors.fontWhite : AppColors.fontBlack,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "This tropical house plant is a structural sensation within your home or office decor. It's variegated leaves show off dark green to lighter greenish-gray horizontal bands with light yellow margins.",
                      style: AppTypography.bodySmallMedium.copyWith(
                        color:
                        isDark ? AppColors.fontWhite : AppColors.fontBlack,
                        height: 1.6,
                      ),
                    ),

                    SizedBox(height: 28.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        DetailItem(title: "Size", value: "Medium"),
                        DetailItem(title: "Plant", value: "ZZ Plant"),
                        DetailItem(title: "Height", value: "20.5"),
                        DetailItem(title: "Humidity", value: "80%"),
                      ],
                    ),

                    SizedBox(height: 32.h),

                    // Quantity
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quantity",
                          style: AppTypography.bodyLargeBold.copyWith(
                            color: isDark
                                ? AppColors.fontWhite
                                : AppColors.fontBlack,
                          ),
                        ),
                        Row(
                          children: [
                            QtyButton(
                              icon: "assets/SvgIcons/minus-square.svg",
                              onTap: () {
                                if (quantity > 1) setState(() => quantity--);
                              },
                            ),
                            SizedBox(width: 16.w),
                            Text(quantity.toString(),
                                style: AppTypography.bodyLargeBold),
                            SizedBox(width: 16.w),
                            QtyButton(
                              icon: "assets/SvgIcons/plus-square.svg",
                              onTap: () => setState(() => quantity++),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price — UNCHANGED
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Price",
                                style: AppTypography.bodyLargeBold),
                            SizedBox(height: 5.h),
                            Text(
                              "\$${product.price.toStringAsFixed(2)}",
                              style: AppTypography.h5Bold,
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            // Add to Cart — outlined
                            SizedBox(
                              height: 48.h,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: AppColors.main500, width: 1.5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 14.w),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                onPressed: _addingToCart ? null : _addToCart,
                                child: _addingToCart
                                    ? SizedBox(
                                  width: 18.w,
                                  height: 18.h,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.main500,
                                  ),
                                )
                                    : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/SvgIcons/shopping-cart-03.svg",
                                      width: 18.w,
                                      colorFilter:
                                      const ColorFilter.mode(
                                        AppColors.main500,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      "Add",
                                      style: AppTypography
                                          .bodyMediumBold
                                          .copyWith(
                                          color: AppColors.main500),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(width: 10.w),

                            // Buy Now — filled, same height
                            SizedBox(
                              height: 48.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.main500,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 14.w),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                onPressed: _buyingNow ? null : _buyNow,
                                child: _buyingNow
                                    ? SizedBox(
                                  width: 18.w,
                                  height: 18.h,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                                    : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/SvgIcons/shopping-bag-02.svg",
                                      width: 18.w,
                                      colorFilter:
                                      const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      "Buy Now",
                                      style: AppTypography
                                          .bodyMediumBold
                                          .copyWith(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}