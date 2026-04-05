import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/di/providers.dart';
import '../../../../../core/shared_widgets/cards/product_card_widget.dart';
import '../../../../../core/shared_widgets/navigation/navigation1.dart';
import '../../../../../core/shared_widgets/sort_by/sort_by.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';

class FavoritePlantScreen extends ConsumerWidget {
  const FavoritePlantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final productsState = ref.watch(homeViewModelProvider);

    String selectedSort = "Lowest Price";

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
          child: productsState.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) =>
            const Center(child: Text("Failed to load favorites")),
            data: (products) {
              final favoritePlants =
              products.where((p) => p.isLiked).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Navigation1(
                    title: 'Favorites',
                    onBackPressed: () => Navigator.pop(context),
                  ),

                  SizedBox(height: 24.h),

                  if (favoritePlants.isEmpty)
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/SvgIcons/not_found.svg",
                              width: 160.w,
                              height: 160.h,
                            ),
                            SizedBox(height: 24.h),
                            SizedBox(
                              width: 380.w,
                              child: Text(
                                'Not Favorite Yet',
                                textAlign: TextAlign.center,
                                style: AppTypography.bodyLargeBold.copyWith(
                                  color: isDark
                                      ? AppColors.fontWhite
                                      : Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            SizedBox(
                              width: 268.w,
                              child: Text(
                                "You don't have a favorite plant list yet",
                                textAlign: TextAlign.center,
                                style: AppTypography.bodyNormalRegular
                                    .copyWith(color: AppColors.fontGrey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${favoritePlants.length} Plants",
                          style: AppTypography.bodyLargeBold.copyWith(
                            color:
                            isDark ? AppColors.fontWhite : Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) {
                                return Stack(
                                  children: [
                                    Opacity(
                                      opacity: 0.65,
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SortByBottomSheet(
                                        name: "Sort By",
                                        selectedOption: selectedSort,
                                        options: const [
                                          "Latest Saved",
                                          "Longest Saved",
                                          "Most Reviews",
                                          "Highest Price",
                                          "Lowest Price",
                                        ],
                                        onOptionSelected: (option) {
                                          selectedSort = option;
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "Sort",
                                style: AppTypography.bodyMediumMedium
                                    .copyWith(color: AppColors.fontGrey),
                              ),
                              SizedBox(width: 8.w),
                              SvgPicture.asset(
                                "assets/SvgIcons/sort.svg",
                                width: 24.w,
                                height: 24.h,
                                color: AppColors.fontGrey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    Expanded(
                      child: GridView.builder(
                        itemCount: favoritePlants.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16.h,
                          crossAxisSpacing: 16.w,
                          childAspectRatio: 176 / 310,
                        ),
                        itemBuilder: (context, index) {
                          final product = favoritePlants[index];
                          final originalIndex =
                          products.indexWhere((p) => p.id == product.id);

                          return ProductCard(
                            product: product,
                            onLikeToggle: () => ref
                                .read(homeViewModelProvider.notifier)
                                .toggleLike(originalIndex),
                            // ✅ Add to cart from favorites grid
                            onAddToCart: () async {
                              await ref
                                  .read(cartProvider.notifier)
                                  .addToCart(product, 1);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${product.title} added to cart'),
                                    duration: const Duration(seconds: 1),
                                    backgroundColor: AppColors.main500,
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}