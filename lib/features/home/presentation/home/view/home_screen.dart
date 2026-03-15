import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/providers.dart';
import '../../../../../core/shared_widgets/cards/discount_banner_with_dots.dart';
import '../../../../../core/shared_widgets/cards/product_card_widget.dart';
import '../../../../../core/shared_widgets/form_fields/app_input_field/app_input_field.dart';
import '../../../../../core/shared_widgets/navigation/navigation4.dart';
import '../../../../../core/shared_widgets/selection/plant_category_selection/plant_category_selector.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../router.dart';
import '../../../../list_plant/presentation/availble_plant/widgets/card_filter_bottom_sheet.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentBanner = 0;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<int> _bannerIndexNotifier = ValueNotifier(0);
  final double bannerWidth = 264;
  final double bannerSpacing = 12;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }


  void _onScroll() {
    final itemWidth = bannerWidth + bannerSpacing;
    final index = (_scrollController.offset / itemWidth).round();

    if (index >= 0 && index < 3) {
      if (_bannerIndexNotifier.value != index) {
        _bannerIndexNotifier.value = index;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _bannerIndexNotifier.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(userProfileProvider);
    final addressAsync = ref.watch(userAddressesProvider);
    final productsState = ref.watch(homeViewModelProvider);
    final viewModel = ref.read(homeViewModelProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 32.h, bottom: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: profileAsync.when(
                  loading: () => const Navigation4(name: '', location: ''),
                  error: (_, __) => const Navigation4(name: '', location: ''),
                  data: (profile) {

                    return addressAsync.when(
                      loading: () => Navigation4(
                        name: profile?.fullName ?? '',
                        location: '',
                      ),
                      error: (_,__) => Navigation4(
                        name: profile?.fullName ?? '',
                        location: '',
                      ),
                      data: (addresses) {

                        final address =
                        addresses.isNotEmpty ? addresses.first : null;

                        return Navigation4(
                          name: profile?.fullName ?? '',
                          location: address?.address ?? '',
                          imagePath: profile?.imagePath,
                          onBellTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRouter.homenotifictionscreen,
                            );
                          },
                          onHeartTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRouter.favoriteplantscreen,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),

              SizedBox(height: 12.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child:  AppInputField(
                  label: '',
                  hintText: 'Search',
                  leadingIconPath: 'assets/SvgIcons/search-sm.svg',
                  trailingIconPath: 'assets/SvgIcons/filter-lines.svg',onTrailingIconTap: () {
                  final products = ref.read(homeViewModelProvider).value ?? [];

                  PlantFilterFullSheet.show(
                    context,
                    products: products,
                    viewModel: viewModel,
                    initialCategory: "",
                    initialRange: const RangeValues(0, 1000),
                    initialSortIndex: 0,
                    onApply: (category, range, sortIndex) {},
                  );
                },
                    onChanged: (value) {
                      ref.read(homeViewModelProvider.notifier)
                          .search(value);
                    }
                ),
              ),

              SizedBox(height: 32.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child:  Text(
                  'Special Offers',
                  style: AppTypography.bodyNormalBold.copyWith(
                    color: isDark ? AppColors.fontWhite: AppColors.fontBlack,
                  )
                ),
              ),

              SizedBox(height: 18.h),

              NotificationListener<ScrollEndNotification>(
                onNotification: (_) {
                  _onScroll();
                  return false;
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      children: const [
                        DiscountBannerCard(
                          title: '30% Discount',
                          description:
                          'Get Discount for every orders, only valid\nfor today',
                          imagePath: 'assets/images/banner1.jpg',
                        ),
                        SizedBox(width: 12),
                        DiscountBannerCard(
                          title: '10% Discount',
                          description:
                          'Get Discount for every orders, only valid\nfor today',
                          imagePath: 'assets/images/banner2.jpg',
                        ),
                        SizedBox(width: 12),
                        DiscountBannerCard(
                          title: 'Free Delivery',
                          description:
                          'On all orders above \$50 this week only!',
                          imagePath: 'assets/images/banner2.jpg',
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child:ValueListenableBuilder<int>(
                  valueListenable: _bannerIndexNotifier,
                  builder: (context, index, _) {
                    return DiscountDotsIndicator(
                      itemCount: 3,
                      currentIndex: index,
                    );
                  },
                ),
              ),

              PlantCategorySelector(
                categories: const [
                  "All",
                  "Indoor",
                  "Outdoor",
                  "Garden",
                  "Orchid",
                ],
                selectedCategory: "All",
                onCategorySelected: (id) {
                  ref.read(homeViewModelProvider.notifier)
                      .loadProductsByCategory(id);
                },
              ),
              SizedBox(height: 22.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      'Most Popular',
                      style: AppTypography.bodyNormalBold.copyWith(
                        color: isDark ? AppColors.fontWhite: AppColors.fontBlack,
                      )
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRouter.availablePlants);
                      },
                      child:  Text(
                        'View All',
                        style: AppTypography.bodyNormalBold.copyWith(
                          color: AppColors.main500,
                        )
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: productsState.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (e, _) => const Center(
                    child: Text("Failed to load products"),
                  ),
                  data: (products) {
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: products.length > 4 ? 4 : products.length,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20.h,
                        crossAxisSpacing: 16.w,
                        childAspectRatio: 0.57,
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];

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
                            onLikeToggle: () =>
                                viewModel.toggleLike(index),
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