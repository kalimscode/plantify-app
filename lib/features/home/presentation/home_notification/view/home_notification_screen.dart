import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/features/home/presentation/home_notification/widgets/notification_card.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/shared_widgets/sort_by/sort_by.dart';

class HomeNotificationScreen extends ConsumerWidget {
  const HomeNotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // ✅ Sort options
    final List<String> sortOptions = [
      'All notifications',
      'Unread notification',
      'Promo',
      'Account',
      'Offer',
    ];

    final today = [
      {
        'icon': 'assets/SvgIcons/shopping-cart-03.svg',
        'title': 'Payment Successful',
        'desc':
        'Congratulations! You successfully bought a plant for \$25. Enjoy the service.',
      },
      {
        'icon': 'assets/SvgIcons/shopping-bag-02.svg',
        'title': 'New Service Available',
        'desc':
        'You can buy plants easily and we have a credit simulation to make the buying process easier.',
      },
    ];

    final yesterday = [
      {
        'icon': 'assets/SvgIcons/wallet-03.svg',
        'title': 'Add Payment Complete',
        'desc':
        'Your add new payment is successful, you can experience our service',
      },
      {
        'icon': 'assets/SvgIcons/sale-03.svg',
        'title': 'Discount Available',
        'desc': 'We recommend a 5% discount for all plants.',
      },
      {
        'icon': 'assets/SvgIcons/user-02.svg',
        'title': 'Account Setup Successfully',
        'desc':
        'Your account creation is successful, you can now experience our service',
      },
    ];

    return Scaffold(
      backgroundColor:
      isDark ? AppColors.dark500 : AppColors.white500,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        size: 24.sp,
                        color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                       ),
                    ),

                    SizedBox(width: 12.w),
                          Text(
                      'Notifications',
                      style: AppTypography.h5Bold.copyWith(
                        color:
                        isDark ? AppColors.fontWhite : AppColors.fontBlack,
                      ),
                    ),

                    const Spacer(),

                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          barrierColor:
                          Colors.black.withOpacity(0.45),
                          isScrollControlled: true,
                          builder: (context) {
                            return SortByBottomSheet(
                              name: "Sort By",
                              selectedOption:
                              "All notifications",
                              options: sortOptions,
                              onOptionSelected: (value) {
                                debugPrint(
                                    "Selected option: $value");
                              },
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.more_horiz,
                        size: 24.sp,
                        color:
                        isDark ? AppColors.fontWhite : AppColors.fontBlack,
                      ),
                    ),

                    SizedBox(width: 8.w),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Today',
                  style: AppTypography.bodyMediumBold.copyWith(
                    color:
                    isDark ? AppColors.fontWhite : AppColors.fontBlack,
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: today
                      .map(
                        (n) => Padding(
                      padding:
                      EdgeInsets.only(bottom: 16.h),
                      child: NotificationCard(
                        iconPath: n['icon']!,
                        title: n['title']!,
                        description: n['desc']!,
                      ),
                    ),
                  )
                      .toList(),
                ),
              ),

              SizedBox(height: 32.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Yesterday',
                  style: AppTypography.bodyMediumBold.copyWith(
                    color:
                    isDark ? AppColors.fontWhite : AppColors.fontBlack,
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: yesterday
                      .map(
                        (n) => Padding(
                      padding:
                      EdgeInsets.only(bottom: 16.h),
                      child: NotificationCard(
                        iconPath: n['icon']!,
                        title: n['title']!,
                        description: n['desc']!,
                      ),
                    ),
                  )
                      .toList(),
                ),
              ),

              SizedBox(height: 147.h),
            ],
          ),
        ),
      ),
    );
  }
}