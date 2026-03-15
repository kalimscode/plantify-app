import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// 🌿 Combined Discount Banner Carousel with Dots
class DiscountBannerWithDots extends StatefulWidget {
  const DiscountBannerWithDots({super.key});

  @override
  State<DiscountBannerWithDots> createState() => _DiscountBannerWithDotsState();
}

class _DiscountBannerWithDotsState extends State<DiscountBannerWithDots> {
  final PageController _pageController = PageController(
    viewportFraction: 1.0, // 👈 shows only one full banner, hides edges
  );

  int _currentIndex = 0;

  final List<Map<String, String>> _banners = [
    {
      'title': '30% Discount',
      'description': 'Get Discount for every orders, only valid\nfor today',
      'image': 'assets/images/banner1.jpg',
    },
    {
      'title': '10% Discount',
      'description': 'Get Discount for every orders, only valid\nfor today',
      'image': 'assets/images/banner2.jpg',
    },
    {
      'title': 'Free Delivery',
      'description': 'On all orders above \$50 this week only!',
      'image': 'assets/images/banner2.jpg',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🌿 PageView for banners
        SizedBox(
          height: 140.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _banners.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              final banner = _banners[index];
              return Padding(
                // 👇 Adds edge padding to make banners not touch screen edge
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: DiscountBannerCard(
                  title: banner['title']!,
                  description: banner['description']!,
                  imagePath: banner['image']!,
                ),
              );
            },
          ),
        ),

        // 🔘 Dots Indicator below banner
        SizedBox(height: 16.h),
        DiscountDotsIndicator(
          itemCount: _banners.length,
          currentIndex: _currentIndex,
        ),
      ],
    );
  }
}

/// 🪴 Reusable Banner Card
class DiscountBannerCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const DiscountBannerCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290.w,
      height: 145.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Overlay for dim effect
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),

          // Text + Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.7.w, vertical: 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: AppTypography.bodyLargeBold.copyWith(
                    color: AppColors.white500,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 1.h),

                // Description
                Expanded(
                  child: Text(
                    description,
                    style: AppTypography.bodySmallMedium.copyWith(
                      color: AppColors.white500,
                      height: 1.38.h,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8.h),

                // Button
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.main500,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Shop Now',
                    style: AppTypography.bodyNormalBold.copyWith(
                      color: AppColors.white500,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔘 Dots Indicator (used below banners)
class DiscountDotsIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const DiscountDotsIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: currentIndex == index ? 10.w : 8.w,
          height: currentIndex == index ? 10.w : 8.w,
          decoration: ShapeDecoration(
            color: currentIndex == index
                ? AppColors.main500
                : AppColors.main100,
            shape: const OvalBorder(),
          ),
        ),
      ),
    );
  }
}
