import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';
import 'package:plantify/features/setup_profile_pages/pin/presentation/widget/pin_screen_loading_widget.dart';
import 'package:plantify/router.dart';

import '../../../../../core/di/providers.dart';

enum SuccessPopupFlow { addressPin, paymentPin }

class SuccessPopupWidget extends ConsumerWidget {
  final SuccessPopupFlow flow;

  const SuccessPopupWidget({super.key, required this.flow});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Future.delayed(const Duration(seconds: 3), () {
      if (flow == SuccessPopupFlow.addressPin) {
        Navigator.of(context).pushReplacementNamed(AppRouter.mainWrapper);
      }
    });

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        width: 300.w,
        padding: EdgeInsets.only(bottom: 20.h),
        decoration: ShapeDecoration(
          color: isDark ? AppColors.dark500 : AppColors.white500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 300.h,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              decoration: ShapeDecoration(
                color: AppColors.main500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  if (flow == SuccessPopupFlow.addressPin)
                    SvgPicture.asset(
                      'assets/SvgIcons/user-02.svg',
                      width: 100.w,
                      height: 100.h,
                      color: AppColors.fill03,
                    )
                  else
                    SvgPicture.asset(
                      'assets/SvgIcons/shopping-cart-03.svg',
                      width: 100.w,
                      height: 100.h,
                      color: AppColors.fill03,
                    ),

                  SizedBox(height: 20.h),

                  Text(
                    'Congratulation',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyLargeBold.copyWith(
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      flow == SuccessPopupFlow.addressPin
                          ? 'Your account is ready to use. You will be redirected to the Home Page in a few seconds.'
                          : 'Show House Successfully booked. You can check your booking on the menu profile -> Menu Booking',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodySmallBold.copyWith(
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            if (flow == SuccessPopupFlow.addressPin)
              const pin_screen_loading()
            else
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: TextButton(
                  child: Text(
                    'View Receipt',
                    style: AppTypography.bodyLargeBold.copyWith(
                      color: isDark ? AppColors.white500 : AppColors.dark500,
                    ),
                  ),
                  onPressed: () {

                    final order = ref.read(orderProvider).lastOrder;

                    Navigator.pushNamed(
                      context,
                      AppRouter.detailereceipt,
                      arguments: order,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}