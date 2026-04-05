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

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fabCtrl;
  late Animation<double> _fabExpand;
  late Animation<double> _fabFade;
  bool _fabExpanded = false;

  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<int> _bannerIndexNotifier = ValueNotifier(0);
  final double bannerWidth = 264;
  final double bannerSpacing = 12;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    _fabCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fabExpand = CurvedAnimation(parent: _fabCtrl, curve: Curves.easeOut);
    _fabFade = CurvedAnimation(parent: _fabCtrl, curve: Curves.easeIn);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 400), () {
        if (!mounted) return;
        setState(() => _fabExpanded = true);
        _fabCtrl.forward();
        Future.delayed(const Duration(milliseconds: 2500), () {
          if (!mounted) return;
          _fabCtrl.reverse().then((_) {
            if (mounted) setState(() => _fabExpanded = false);
          });
        });
      });
    });
  }

  void _onScroll() {
    final itemWidth = bannerWidth + bannerSpacing;
    final index = (_scrollController.offset / itemWidth).round();
    if (index >= 0 && index < 3 && _bannerIndexNotifier.value != index) {
      _bannerIndexNotifier.value = index;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _bannerIndexNotifier.dispose();
    _fabCtrl.dispose();
    super.dispose();
  }

  Future<void> _goToProfile() async {
    await Navigator.pushNamed(
      context,
      AppRouter.setupProfile,
      arguments: {'isEditMode': true},
    );
    ref.invalidate(userProfileProvider);
  }


  Future<void> _goToAddress() async {
    final addresses = ref.read(userAddressesProvider).value ?? [];
    if (addresses.isEmpty) {
      await Navigator.pushNamed(context, AppRouter.addNewAddress);
    } else {
      await Navigator.pushNamed(context, AppRouter.checkoutSelectAddress);
    }
    ref.invalidate(userAddressesProvider);
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(userProfileProvider);
    final addressAsync = ref.watch(userAddressesProvider);
    final selectedAddress = ref.watch(addressProvider);
    final productsState = ref.watch(homeViewModelProvider);
    final viewModel = ref.read(homeViewModelProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final String profileName =
        profileAsync.whenOrNull(data: (p) => p?.fullName) ?? '';
    final String? profileImage =
    profileAsync.whenOrNull(data: (p) => p?.imagePath);
    final String locationText = selectedAddress?.address ??
        (addressAsync.whenOrNull(
          data: (list) => list.isNotEmpty ? list.first.address : null,
        ) ??
            '');

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      floatingActionButton: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppRouter.aiChat),
        child: AnimatedBuilder(
          animation: _fabCtrl,
          builder: (_, __) => Container(
            height: 52.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF43A047), Color(0xFF1B5E20)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.main500.withOpacity(0.35),
                  blurRadius: 12.r,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PlantAiIcon(expanded: _fabExpanded),
                ClipRect(
                  child: SizeTransition(
                    sizeFactor: _fabExpand,
                    axis: Axis.horizontal,
                    axisAlignment: -1,
                    child: FadeTransition(
                      opacity: _fabFade,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w, right: 2.w),
                        child: Text(
                          'Ask Plant AI',
                          style: AppTypography.bodySmallBold
                              .copyWith(color: AppColors.fontWhite),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 32.h, bottom: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Navigation4(
                  name: profileName,
                  location: locationText,
                  imagePath: profileImage,
                  onAvatarTap: _goToProfile,
                  onNameTap: _goToProfile,
                  onLocationTap: _goToAddress,
                  onBellTap: () => Navigator.pushNamed(
                      context, AppRouter.homenotifictionscreen),
                  onHeartTap: () => Navigator.pushNamed(
                      context, AppRouter.favoriteplantscreen),
                ),
              ),

              SizedBox(height: 12.h),

              // ── Search ────────────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: AppInputField(
                  label: '',
                  hintText: 'Search',
                  leadingIconPath: 'assets/SvgIcons/search-sm.svg',
                  trailingIconPath: 'assets/SvgIcons/filter-lines.svg',
                  onTrailingIconTap: () {
                    final products =
                        ref.read(homeViewModelProvider).value ?? [];
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
                  onChanged: (value) =>
                      ref.read(homeViewModelProvider.notifier).search(value),
                ),
              ),

              SizedBox(height: 32.h),

              // ── Banners ───────────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Special Offers',
                  style: AppTypography.bodyNormalBold.copyWith(
                    color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                  ),
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
                child: ValueListenableBuilder<int>(
                  valueListenable: _bannerIndexNotifier,
                  builder: (context, index, _) => DiscountDotsIndicator(
                    itemCount: 3,
                    currentIndex: index,
                  ),
                ),
              ),

              // ── Categories ────────────────────────────────────────────────
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
              SizedBox(height: 22.h),

              // ── Products ──────────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Most Popular',
                      style: AppTypography.bodyNormalBold.copyWith(
                        color:
                        isDark ? AppColors.fontWhite : AppColors.fontBlack,
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRouter.availablePlants),
                      child: Text(
                        'View All',
                        style: AppTypography.bodyNormalBold
                            .copyWith(color: AppColors.main500),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: productsState.when(
                  loading: () =>
                  const Center(child: CircularProgressIndicator()),
                  error: (e, _) =>
                  const Center(child: Text("Failed to load products")),
                  data: (products) => GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: products.length > 4 ? 4 : products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20.h,
                      crossAxisSpacing: 16.w,
                      childAspectRatio: 0.57,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRouter.plantDetail,
                          arguments: product,
                        ),
                        child: ProductCard(
                          product: product,
                          onLikeToggle: () => viewModel.toggleLike(index),
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
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── FAB Icon ─────────────────────────────────────────────────────────────────

class _PlantAiIcon extends StatefulWidget {
  final bool expanded;
  const _PlantAiIcon({required this.expanded});
  @override
  State<_PlantAiIcon> createState() => _PlantAiIconState();
}

class _PlantAiIconState extends State<_PlantAiIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmer;
  late Animation<double> _shimmerAnim;

  @override
  void initState() {
    super.initState();
    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _shimmerAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _shimmer, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shimmer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerAnim,
      builder: (_, __) => Stack(
        alignment: Alignment.center,
        children: [
          if (widget.expanded)
            Container(
              width: 34.w,
              height: 34.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.15 * _shimmerAnim.value),
              ),
            ),
          Container(
            width: 28.w,
            height: 28.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.4),
            ),
            child:
            Center(child: Text('🌿', style: TextStyle(fontSize: 15.sp))),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(_shimmerAnim.value),
                border: Border.all(color: AppColors.main500, width: 1),
              ),
              child: Center(
                child: Icon(Icons.smart_toy_outlined,
                    size: 5.w, color: AppColors.fontWhite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}