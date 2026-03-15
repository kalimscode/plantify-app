import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/shared_widgets/action_buttons/action_button.dart';
import 'package:plantify/core/shared_widgets/navigation/navigation1.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';

import '../../../core/shared_widgets/form_fields/app_input_field/app_input_field.dart';

class AddPaymentMethodScreen extends StatelessWidget {
  const AddPaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(

        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Navigation1(title: 'Add Payment Methods'),
              SizedBox(height: 24.h,),
              Container(
                width: double.infinity,
                height: 200.h,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1C1C1C),
                      Color(0xFF000000),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mocard',
                          style: AppTypography.bodyMediumBold
                              .copyWith(color: AppColors.fontWhite),
                        ),
                        Text(
                          'Visa',
                          style: AppTypography.bodyMediumBold
                              .copyWith(color: AppColors.fontWhite),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    Row(
                      children: List.generate(
                        12,
                            (index) => Container(
                          margin: EdgeInsets.only(right: 6.w),
                          width: 8.w,
                          height: 8.h,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _CardInfo(
                          title: 'Card Header Name',
                          value: '••••••••',
                        ),
                        _CardInfo(
                          title: 'Expiry Date',
                          value: '••••••••',
                        ),
                        SvgPicture.asset(
                          'assets/SvgIcons/Mastercard.svg',
                          width: 40.w,
                          height: 40.w,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              AppInputField(
                label: 'Card Number',
                hintText: '1234 343432 9843 2134',
                leadingIconPath: 'assets/SvgIcons/wallet-03.svg',
              ),

              SizedBox(height: 16.h),

              AppInputField(
                label: 'Card Name',
                hintText: 'Wallet 02',
                leadingIconPath: 'assets/SvgIcons/wallet-03.svg',
              ),

              SizedBox(height: 16.h),

              Row(
                children: [
                  Expanded(
                    child: AppInputField(
                      label: 'Expired Date',
                      hintText: '18/03/2023',
                      leadingIconPath:
                      'assets/SvgIcons/calendar-date.svg',
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: AppInputField(
                      label: 'CVV',
                      hintText: '7777',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              /// Add Payment Button
              ActionButton(text: 'Add New Payment',
              variant: ButtonVariant.primary,
              size: ButtonSize.full,
              onPressed: (){
                Navigator.pop(context);
              },
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// 🔹 Card Info Widget
class _CardInfo extends StatelessWidget {
  final String title;
  final String value;

  const _CardInfo({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.bodySmallRegular
              .copyWith(color: Colors.white70),
        ),
        SizedBox(height: 6.h),
        Text(
          value,
          style: AppTypography.bodyMediumBold
              .copyWith(color: AppColors.fontWhite),
        ),
      ],
    );
  }
}
