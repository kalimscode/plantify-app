import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/shared_widgets/action_buttons/action_button.dart';
import 'package:plantify/features/list_plant/presentation/availble_plant/widgets/price_range_section.dart';
import '../../../../../core/shared_widgets/selection/plant_category_selection/plant_category_selector.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../home/presentation/home/viewmodel/home_viewmodel.dart';
import '../../plant_filter_result/plant_filter_result_screen.dart';


class PlantFilterFullSheet {

  static Future<void> show(
      BuildContext context, {

        required List products,
        required HomeViewModel viewModel,
        required String initialCategory,
        required RangeValues initialRange,
        required int initialSortIndex,

        required void Function(
            String categoryA,
            RangeValues priceRange,
            int sortIndex,
            ) onApply,

      }) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showModalBottomSheet(

      context: context,
      isScrollControlled: true,

      backgroundColor: isDark
          ? AppColors.dark500
          : AppColors.white500,

      barrierColor: Colors.black.withOpacity(0.65),

      builder: (_) {

        return _PlantFilterCard(

          products: products,
          viewModel: viewModel,
          initialCategory: initialCategory,
          initialRange: initialRange,
          initialSortIndex: initialSortIndex,
          onApply: onApply,

        );
      },

    );
  }
}

class _PlantFilterCard extends StatefulWidget {

  final List products;
  final HomeViewModel viewModel;
  final String initialCategory;
  final RangeValues initialRange;
  final int initialSortIndex;

  final void Function(
      String,
      RangeValues,
      int
      ) onApply;

  const _PlantFilterCard({

    super.key,
    required this.products,
    required this.viewModel,
    required this.initialCategory,
    required this.initialRange,
    required this.initialSortIndex,
    required this.onApply,

  });

  @override
  State<_PlantFilterCard> createState() => _PlantFilterCardState();
}

class _PlantFilterCardState extends State<_PlantFilterCard> {

  final List<String> categories = [
    "All",
    "Indoor",
    "Outdoor",
    "Garden",
    "Orchid",
  ];

  final List<String> sortOptions = [
    "Popular",
    "Price High",
    "Most Recent",
    "Price Low",
  ];

  late String selectedCategory;
  late int selectedSortIndex;

  @override
  void initState() {

    super.initState();

    selectedCategory =
    widget.initialCategory.isEmpty
        ? "All"
        : widget.initialCategory;

    selectedSortIndex =
        widget.initialSortIndex;
  }

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(

      height: 0.62.sh,

      padding: EdgeInsets.only(

        top: 27.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,

      ),

      decoration: BoxDecoration(

        color: isDark
            ? AppColors.dark500
            : AppColors.white500,

        borderRadius:  BorderRadius.vertical(
            top: Radius.circular(16.r)
        ),

      ),

      child: SingleChildScrollView(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "Type Plant",
                style: AppTypography.bodyMediumBold.copyWith(
                  color: isDark
                      ? AppColors.fontWhite
                      : AppColors.fontBlack,
                ),
              ),
            ),

            SizedBox(height: 24.h),

            PlantCategorySelector(

              categories: categories,
              selectedCategory: selectedCategory,

              onCategorySelected: (category) {

                setState(() {

                  selectedCategory = category;

                });

              },

            ),

            SizedBox(height: 24.h),

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),

                child: PriceRangeSection()),

            SizedBox(height: 16.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "Sort By",
                style: AppTypography.bodyMediumBold.copyWith(
                  fontSize: 16.sp,
                  color: isDark
                      ? AppColors.fontWhite
                      : AppColors.fontBlack,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            PlantCategorySelector(

              categories: sortOptions,
              selectedCategory: sortOptions[selectedSortIndex],

              onCategorySelected: (sort) {

                setState(() {

                  selectedSortIndex =
                      sortOptions.indexOf(sort);

                });

              },

            ),

            SizedBox(height: 16.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),

              child: Row(

                children: [

                  Expanded(

                    child: ActionButton(text: 'Reset',variant: ButtonVariant.line,
                      size: ButtonSize.medium,
                      onPressed: () {

                        setState(() {

                          selectedCategory = "All";
                          selectedSortIndex = 0;

                        });

                      },

                    )
                  ),

                  SizedBox(width: 12.w),

                  Expanded(

                    child: ActionButton(text: 'Apply Filter',
                      onPressed: () {

                        final filtered =
                        widget.products.where((plant) {

                          final matchesCategory =
                              selectedCategory == "All"
                                  || plant.category == selectedCategory;

                          final matchesPrice =
                              plant.price >= widget.initialRange.start
                                  && plant.price <= widget.initialRange.end;

                          return matchesCategory
                              && matchesPrice;

                        }).toList();

                        Navigator.pop(context);

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                                plant_filter_result_screen(

                                  categoryTitle: selectedCategory,
                                  filteredPlants: filtered,

                                ),

                          ),

                        );

                      },
variant: ButtonVariant.primary,
                      size: ButtonSize.medium,
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}