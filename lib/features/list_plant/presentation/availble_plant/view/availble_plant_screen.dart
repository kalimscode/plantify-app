import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/shared_widgets/selection/plant_category_selection/plant_category_selector.dart';
import 'package:plantify/features/list_plant/presentation/availble_plant/widgets/card_filter_bottom_sheet.dart';
import '../../../../../../core/shared_widgets/cards/product_card_widget.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/shared_widgets/navigation/navigation1.dart';
import '../../../../../core/di/providers.dart';
import '../../../../../core/shared_widgets/form_fields/app_input_field/app_input_field.dart';
import '../../../../../router.dart';

class AvailablePlantsScreen extends ConsumerStatefulWidget {
  const AvailablePlantsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AvailablePlantsScreen> createState() =>
      _AvailablePlantsScreenState();
}

class _AvailablePlantsScreenState
    extends ConsumerState<AvailablePlantsScreen> {
  String searchText = "";
  String selectedCategory = "";
  RangeValues filterPrice = const RangeValues(0, 1000);
  int selectedSort = 0;

  List sortProducts(List products) {
    List sorted = List.from(products);
    switch (selectedSort) {
      case 1:
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 2:
        sorted.sort((a, b) => b.id.compareTo(a.id));
        break;
      case 3:
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      default:
        break;
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(homeViewModelProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final productsState = ref.watch(homeViewModelProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 16.h, bottom: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Navigation1(
                  title: "Available Plants",
                  onBackPressed: () => Navigator.pop(context),
                ),
              ),

              SizedBox(height: 20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: AppInputField(
                  label: '',
                  hintText: 'Search plants...',
                  leadingIconPath: 'assets/SvgIcons/search-sm.svg',
                  trailingIconPath: 'assets/SvgIcons/filter-lines.svg',
                  onTrailingIconTap: () {
                    final products =
                        ref.read(homeViewModelProvider).value ?? [];
                    PlantFilterFullSheet.show(
                      context,
                      products: products,
                      viewModel: viewModel,
                      initialCategory: selectedCategory,
                      initialRange: filterPrice,
                      initialSortIndex: selectedSort,
                      onApply: (category, priceRange, sortIndex) {
                        setState(() {
                          selectedCategory =
                          category == "All" ? "" : category;
                          filterPrice = priceRange;
                          selectedSort = sortIndex;
                        });
                      },
                    );
                  },
                  onChanged: (value) => setState(() => searchText = value),
                ),
              ),

              SizedBox(height: 20.h),

              PlantCategorySelector(
                categories: const [
                  "All",
                  "Indoor",
                  "Outdoor",
                  "Garden",
                  "Orchid",
                ],
                selectedCategory: "All",
                onCategorySelected: (id) => ref
                    .read(homeViewModelProvider.notifier)
                    .loadProductsByCategory(id),
              ),

              SizedBox(height: 20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: productsState.when(
                  loading: () =>
                  const Center(child: CircularProgressIndicator()),
                  error: (e, _) =>
                  const Center(child: Text("Failed to load plants")),
                  data: (products) {
                    final filteredProducts = products.where((plant) {
                      final matchesSearch = searchText.isEmpty ||
                          plant.title
                              .toLowerCase()
                              .contains(searchText.toLowerCase());
                      final matchesPrice = plant.price >= filterPrice.start &&
                          plant.price <= filterPrice.end;
                      return matchesSearch && matchesPrice;
                    }).toList();

                    final sortedProducts = sortProducts(filteredProducts);

                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: sortedProducts.length,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20.h,
                        crossAxisSpacing: 16.w,
                        childAspectRatio: 0.57,
                      ),
                      itemBuilder: (context, index) {
                        final plant = sortedProducts[index];
                        final originalIndex =
                        products.indexWhere((p) => p.id == plant.id);

                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRouter.plantDetail,
                            arguments: plant,
                          ),
                          child: ProductCard(
                            product: plant,
                            onLikeToggle: () =>
                                viewModel.toggleLike(originalIndex),
                            // ✅ Add to cart from available plants grid
                            onAddToCart: () async {
                              await ref
                                  .read(cartProvider.notifier)
                                  .addToCart(plant, 1);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                    Text('${plant.title} added to cart'),
                                    duration: const Duration(seconds: 1),
                                    backgroundColor: AppColors.main500,
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}