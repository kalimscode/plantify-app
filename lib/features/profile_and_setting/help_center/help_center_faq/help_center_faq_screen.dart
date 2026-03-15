import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/shared_widgets/navigation/navigation1.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';
import 'package:plantify/router.dart';
import '../../../../core/shared_widgets/form_fields/app_input_field/app_input_field.dart';
import '../../../../core/shared_widgets/selection/plant_category_selection/plant_category_selector.dart';

class HelpCenterFaqScreen extends StatefulWidget {
  const HelpCenterFaqScreen({super.key});

  @override
  State<HelpCenterFaqScreen> createState() => _HelpCenterFaqScreenState();
}

class _HelpCenterFaqScreenState extends State<HelpCenterFaqScreen> {
  int selectedTab = 0;
  int selectedCategory = 0;
  int expandedIndex = 0;

  final List<String> categories = [
    'General',
    'Account',
    'Service',
    'Payment',
  ];

  final List<Map<String, String>> faqs = [
    {
      'q': 'What is Plantify',
      'a':
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
    },
    {'q': 'How to use Plantify', 'a': 'You can browse plants and book services easily.'},
    {'q': 'How I can make a payment', 'a': 'Payments can be done using card or wallet.'},
    {'q': 'How do I can cancel a booking', 'a': 'Open your order and press cancel.'},
    {'q': 'How to add promo', 'a': 'Enter promo code during checkout.'},
    {'q': 'Plantify free use', 'a': 'Browsing plants is free in Plantify.'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Navigation1(title: 'Help Center',onBackPressed: () => Navigator.pop(context)),

              SizedBox(height: 18.h),

              _tabs(),

              SizedBox(height: 24.h),

              /// Categories
              PlantCategorySelector(categories: categories, selectedCategory: ''),

              SizedBox(height: 24.h),

              /// Search
            AppInputField(
              label: '',
              hintText: "Search",
              leadingIconPath: 'assets/SvgIcons/search-sm.svg',
              trailingIconPath: 'assets/SvgIcons/filter-lines.svg',
            ),

              SizedBox(height: 24.h),

              /// FAQ List
              _faqList(),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }


  Widget _tabs() {
    return Row(
      children: [
        _tabItem('FAQ', 0),
        _tabItem('Contact us', 1),
      ],
    );
  }

  Widget _tabItem(String title, int index) {
    final bool isActive = selectedTab == index;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (index == 1) {
            Navigator.pushNamed(context, AppRouter.contactus);
          } else {
            Navigator.pushReplacementNamed(context, AppRouter.faq);
          }
        },
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.bodyLargeBold.copyWith(
                color: isActive
                    ? AppColors.main500
                    : (isDark ? AppColors.fontWhite : AppColors.fontBlack),
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              height: isActive ? 4.h : 2.h,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.main500
                    : (isDark ? AppColors.fontWhite : AppColors.fontGrey),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _faqList() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: List.generate(faqs.length, (index) {
        final bool isExpanded = expandedIndex == index;

        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: GestureDetector(
            onTap: () {
              setState(() {
                expandedIndex = isExpanded ? -1 : index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: isExpanded
                    ? null
                    : Border.all(
                  color: isDark
                      ? AppColors.dark400
                      : const Color(0xFFF7F7F7),
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          faqs[index]['q']!,
                          style: AppTypography.bodyNormalBold.copyWith(
                            color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                          )
                        ),
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: AppColors.main500,
                      ),
                    ],
                  ),
                  if (isExpanded) ...[
                    SizedBox(height: 12.h),
                    Text(
                      faqs[index]['a']!,
                      style: AppTypography.bodySmallRegular.copyWith(
                        color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                      )
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}