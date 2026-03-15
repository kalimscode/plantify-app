import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/shared_widgets/action_buttons/action_button.dart';
import 'package:plantify/core/shared_widgets/action_buttons/radio_button.dart';
import 'package:plantify/core/shared_widgets/navigation/navigation1.dart';
import 'package:plantify/features/my_cart_and_transaction/presentation/view/checkout_blank_screen/widget/chekout.dart';
import '../../../../../../core/di/providers.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_typography.dart';
import '../../../../../../router.dart';

class CheckoutBlankFullScreen extends ConsumerWidget {
  const CheckoutBlankFullScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedAddress = ref.watch(addressProvider);
    final cart = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,

      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 52.h, 24.w, 0.h),
        child: Column(
          children: [
           Navigation1(title: 'Check Out',
           onBackPressed: () => Navigator.pop(context),

           ),


            Expanded(
              child: ListView(
                children: [
                  Text(
                    'Address',
                    style: AppTypography.bodyMediumBold.copyWith(
                      color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.checkoutSelectAddress);
                      },

                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.fontGrey,
                          width: 0.01
                        )
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
              color: isDark? AppColors.fill01: AppColors.fill04,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/SvgIcons/marker-pin-01.svg',
                                width: 20.w,
                                color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedAddress?.nameAddress ?? "Select Address",
                                  style: AppTypography.bodyMediumBold.copyWith(
                                    color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                                  )
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  selectedAddress?.address ?? "No address selected",
                                  style: AppTypography.bodySmallRegular.copyWith(
                                    color: AppColors.fontGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                         CustomRadioButton(isActive: true)
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  ...cart.items.map((item) => Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CheckoutItemWidget(
                      image: item.image,
                      title: item.title,
                      size: item.size,
                      price: item.price,
                      quantity: item.quantity,
                      isDark: isDark,
                    ),
                  )).toList(),

                  SizedBox(height: 32.h),

                  Text(
                    'Chose Shipping',
                    style: AppTypography.bodyMediumBold.copyWith(
                      color: isDark? AppColors.fontWhite : AppColors.fontBlack,
                    )
                  ),
                  SizedBox(height: 12.h),
                  GestureDetector(
                          onTap: () async {

                          final price = await Navigator.pushNamed(
                          context,
                          AppRouter.checkoutSelectShipping,
                          );

                          if (price != null) {
                          ref.read(cartProvider.notifier).setShipping(price as double);
                          }


                    },
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.fontGrey,
                            width: 0.01),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/SvgIcons/truck-01.svg',
                            width: 20.w,
                            color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                          ),
                          SizedBox(width: 12.w),

                          Expanded(
                            child: Text(
                              'Chose Shipping Type',
                              style: AppTypography.bodyMediumRegular.copyWith(
                                color: AppColors.fontGrey
                              )
                            ),
                          ),
                           Icon(Icons.arrow_forward_ios, size: 16,color: isDark ? AppColors.fontWhite : AppColors.fontBlack,),
                        ],
                      ),
                    ),
                  ),


                  SizedBox(height: 24.h),

                  Text(
                    'Promo Code',
                    style: AppTypography.bodyMediumBold.copyWith(
                      color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                    )
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.fontGrey,
                      width: 0.01,
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/SvgIcons/sale-03.svg',
                          width: 20.w,
                          color: AppColors.main500,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Enter Promo Code',
                          style: AppTypography.bodyMediumRegular.copyWith(
                            color: AppColors.fontGrey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.fontGrey,
                      width: 0.01,
                      ),
                    ),
                    child: Column(
                      children: [
                        _amountRow("Subtotal", "\$${cart.subtotal.toStringAsFixed(2)}",isDark),
                  SizedBox(height: 8.h),
                  _amountRow("Shipping", "\$${cart.shipping.toStringAsFixed(2)}",isDark),
                  SizedBox(height: 8.h),
                  _amountRow("Total", "\$${cart.total.toStringAsFixed(2)}",isDark),
                      ],
                    ),
                  ),

                SizedBox(height: 38.h),
                  ActionButton(text: 'Continue',
                    variant: ButtonVariant.primary,
                    size: ButtonSize.full,
                    onPressed: (){
                      Navigator.pushNamed(context, AppRouter.checkoutPayment);
                    },
                  ),       ],
              ),
            ),

          ],
        ),
      ),
      
    );
  }

  Widget _amountRow(String title, String value, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTypography.bodyMediumRegular.copyWith(
          color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
        )),
        Text(
          value,
          style: AppTypography.bodyMediumBold.copyWith(
            color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
          ),
        ),
      ],
    );
  }
}
