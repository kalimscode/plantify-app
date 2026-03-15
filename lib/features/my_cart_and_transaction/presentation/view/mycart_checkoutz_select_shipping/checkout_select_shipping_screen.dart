import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/shared_widgets/action_buttons/action_button.dart';
import 'package:plantify/core/shared_widgets/action_buttons/radio_button.dart';
import 'package:plantify/core/shared_widgets/navigation/navigation1.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';

class CheckoutSelectShippingScreen extends StatefulWidget {
  const CheckoutSelectShippingScreen({super.key});

  @override
  State<CheckoutSelectShippingScreen> createState() =>
      _CheckoutSelectShippingScreenState();
}

class _CheckoutSelectShippingScreenState
    extends State<CheckoutSelectShippingScreen> {
  int selectedIndex = 0;

  final List<Map<String, String>> shippingMethods = [
    {
      'title': 'Economy',
      'time': 'Estimated Arrival, Mei 30-31',
      'price': '\$10',
    },
    {
      'title': 'Express',
      'time': 'Estimated Arrival, Mei 30-31',
      'price': '\$30',
    },
    {
      'title': 'Reguler',
      'time': 'Estimated Arrival, Mei 30-31',
      'price': '\$15',
    },
    {
      'title': 'Cargo',
      'time': 'Estimated Arrival, Mei 30-31',
      'price': '\$20',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500: AppColors.white500,


      body: SafeArea(
        child: Column(
          children: [
             SizedBox(height: 24.h),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24.w),
              child: Navigation1(title: 'Select Shipping'),
            ),


             SizedBox(height: 32.h),

            Expanded(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 24.w),
                child: ListView.separated(
                  itemCount: shippingMethods.length,
                  separatorBuilder: (_, __) =>  SizedBox(height: 24.h),
                  itemBuilder: (context, index) {
                    final item = shippingMethods[index];
                    final selected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () => setState(() => selectedIndex = index),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            width: 2.w,
                            color: selected
                                ? AppColors.main500
                                : AppColors.fontGrey
                          ),
                        ),
                        child: Row(
                          children: [
                            /// Truck icon container (same as map container)
                            Container(
                              width: 64.w,
                              height: 68.h,
                              decoration: BoxDecoration(
color: isDark ? AppColors.fill01 : AppColors.fill04,
                              borderRadius: BorderRadius.circular(16.r),
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/SvgIcons/truck-01.svg',
                                width: 28.w,
                                colorFilter:  ColorFilter.mode(
isDark ? AppColors.fontWhite : AppColors.fontBlack,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),

                             SizedBox(width: 12.w),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title']!,
                                    style: AppTypography.bodyMediumBold.copyWith(
                                      color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                                    )
                                  ),
                                   SizedBox(height: 9.h),
                                  Text(
                                    item['time']!,
                                    style: AppTypography.bodyNormalRegular.copyWith(
                                      color: AppColors.fontGrey
                                    )
                                  ),
                                ],
                              ),
                            ),

                            Text(
                              item['price']!,
                              style: AppTypography.bodyNormalBold.copyWith(
                                color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                              )
                            ),

                             SizedBox(width: 12.w),

                            CustomRadioButton(isActive: selected),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        SizedBox(height: 37.h),
            ActionButton(text: 'Confirm Shipping',
              onPressed: () {
                final priceString = shippingMethods[selectedIndex]['price']!;
                final price =
                double.parse(priceString.replaceAll('\$', ''));

                Navigator.pop(context, price);
              }, ),
          ],
        ),
      ),
    );
  }


  }

