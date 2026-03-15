import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/shared_widgets/navigation/navigation1.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';

import '../../../core/shared_widgets/form_fields/app_input_field/app_input_field.dart';

class VoucherListScreen extends StatelessWidget {
  const VoucherListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 32.h),
          child: Column(
            children: [
              Navigation1(title: 'Vouchers'),
              AppInputField(
                      label: '',
                      hintText: 'Search',
                      leadingIconPath: 'assets/SvgIcons/search-sm.svg',
                trailingIconPath: 'assets/SvgIcons/filter-lines.svg',
                    ),

        
              SizedBox(height: 24.h),
        
              /// 🎟 Voucher List
              Expanded(
                child: ListView(
                  children: [
                    _VoucherCard(
                      backgroundColor: AppColors.main500,
                      discountText: 'Save up to \$5.00 for buy plant',
                      code: 'Plant777',
                      minTransaction: '\$25.00',
                    ),
                    SizedBox(height: 16.h),
                    _VoucherCard(
                      backgroundColor: Colors.black,
                      discountText: 'Save up to \$15.00 for buy plant',
                      code: 'Summer Plant7',
                      minTransaction: '\$100.00',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 🎫 Voucher Card
class _VoucherCard extends StatelessWidget {
  final Color backgroundColor;
  final String discountText;
  final String code;
  final String minTransaction;

  const _VoucherCard({
    required this.backgroundColor,
    required this.discountText,
    required this.code,
    required this.minTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/SvgIcons/plantify.svg',
                width: 32.w,
                height: 32.h,
                color: AppColors.fontWhite,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  '#Summersale\n$discountText',
                  style: AppTypography.bodyMediumBold
                      .copyWith(color: AppColors.fontWhite),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),
          Divider(color: Colors.white24),
          SizedBox(height: 12.h),

          /// Coupon Code
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your coupon code:',
                style: AppTypography.bodySmallRegular
                    .copyWith(color: Colors.white70),
              ),
              Text(
                code,
                style: AppTypography.bodyMediumBold
                    .copyWith(color: AppColors.fontWhite),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          Row(
            children: [
              SvgPicture.asset(
                'assets/SvgIcons/calendar-date.svg',
                width: 20.w,
                height: 20.w,
                color: Colors.white70,
              ),
              SizedBox(width: 6.w),
              Text(
                'Mei 31, 2023',
                style: AppTypography.bodySmallRegular
                    .copyWith(color: Colors.white70),
              ),
              const Spacer(),
              SvgPicture.asset(
                'assets/SvgIcons/currency-dollar.svg',
                width: 20.w,
                height: 20.w,
                color: Colors.white70,
              ),
              SizedBox(width: 6.w),
              Text(
                minTransaction,
                style: AppTypography.bodySmallRegular
                    .copyWith(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
