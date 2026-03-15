import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/shared_widgets/cards/product_card_widget.dart';
import '../../../../core/shared_widgets/navigation/navigation1.dart';
import '../../../../core/shared_widgets/sort_by/sort_by.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../router.dart';

class plant_filter_result_screen extends ConsumerStatefulWidget {
  final String categoryTitle;
  final List filteredPlants;

  const plant_filter_result_screen({
    super.key,
    required this.categoryTitle,
    required this.filteredPlants,
  });

  @override
  ConsumerState<plant_filter_result_screen> createState() =>
      _AvailablePlantsScreenState();
}

class _AvailablePlantsScreenState
    extends ConsumerState<plant_filter_result_screen> {
  String selectedSort = "Popular";
  List sortPlants(List plants) {
    List sorted = List.from(plants);

    switch (selectedSort) {
      case "Price High":
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case "Price Low":
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case "Most Recent":
        sorted.sort((a, b) => b.id.compareTo(a.id));
        break;
      default:
        break;
    }

    return sorted;
  }
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final productsState = ref.watch(homeViewModelProvider);
    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Navigation1(
                title: widget.categoryTitle,
                onBackPressed: () => Navigator.pop(context),
              ),

              SizedBox(height: 24.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.filteredPlants.length} Available Plant ${widget.categoryTitle}",
                    style: AppTypography.bodyLargeBold.copyWith(
                      color:
                      isDark ? AppColors.fontWhite : AppColors.fontBlack,
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
                              /// 🖤 Background overlay
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
                                    "Popular",
                                    "Price High",
                                    "Most Recent",
                                    "Price Low",
                                  ],
                                  onOptionSelected: (option) {
                                    setState(() {
                                      selectedSort = option;
                                    });
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
                          style: AppTypography.bodyMediumMedium.copyWith(
                            color: AppColors.fontGrey,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        SvgPicture.asset(
                          "assets/SvgIcons/sort.svg",
                          width: 24.w,
                          height: 24.h,
                          colorFilter: ColorFilter.mode(
                            isDark
                                ? AppColors.fontWhite
                                : AppColors.fontBlack,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 28.h),

          Expanded(
            child: productsState.when(
              loading: () =>
              const Center(child: CircularProgressIndicator()),
              error: (e, _) =>
              const Center(child: Text("Error")),
    data: (allProducts) {

    if (widget.filteredPlants.isEmpty) {
    return const Center(
    child: Text("No plants found"),
    );
    }

    final sortedPlants = sortPlants(widget.filteredPlants);

    return GridView.builder(
    itemCount: sortedPlants.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 20.h,
    crossAxisSpacing: 16.w,
    childAspectRatio: 0.57,
    ),
    itemBuilder: (context, index) {
    final product = sortedPlants[index];
    final originalIndex =
    allProducts.indexWhere((p) => p.id == product.id);

    return GestureDetector(
    onTap: () {
    Navigator.pushNamed(
    context,
    AppRouter.plantDetail,
    arguments: product,
    );
    },
    child: ProductCard(
    product: product,
    onLikeToggle: () {
    ref
        .read(homeViewModelProvider.notifier)
        .toggleLike(originalIndex);
    },
    ),
    );
    },
    );
    }

            ),
          ),
              ],
          ),
        ),
      ),
    );
  }
}
