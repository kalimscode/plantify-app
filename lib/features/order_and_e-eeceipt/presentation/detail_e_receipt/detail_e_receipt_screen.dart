import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/shared_widgets/action_buttons/action_button.dart';
import '../../../../core/shared_widgets/navigation/navigation1.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../router.dart';
import '../../domain/entities/order_entity.dart';


class DetailEReceiptScreen extends ConsumerWidget {
  final OrderEntity order;

  const DetailEReceiptScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final profileAsync = ref.watch(userProfileProvider);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRouter.mainWrapper,
              (route) => false,
        );
        return false;
      },
      child: Scaffold(
backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Navigation1(
                  title: "E-Receipt",
                  onBackPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRouter.mainWrapper,
                          (route) => false,
                    );
                  },
                ),

                SizedBox(height: 24.h),

                Expanded(
                  child: ListView(
                    children: [

                      Row(
                        children: [

                          Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: isDark? AppColors.fill01 : AppColors.fill04,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Image.asset(order.image),
                          ),

                          SizedBox(width: 16.w),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(order.productName,
                                    style: AppTypography.bodyLargeBold.copyWith(
                                      color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                                    )),

                                SizedBox(height: 4.h),

                                Text(
                                  "Size: ${order.size}",
                                  style: AppTypography.bodySmallRegular.copyWith(
                                    color: AppColors.fontGrey
                                  ),
                                ),

                                Text(
                                  "Qty: ${order.quantity}",
                                  style: AppTypography.bodySmallRegular.copyWith(
                                    color: AppColors.fontGrey
                                  ),
                                ),

                                SizedBox(height: 8.h),

                                Text(
                                  "\$${order.price}",
                                  style: AppTypography.bodyLargeBold.copyWith(
                                    color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),

                      SizedBox(height: 24.h),

                      profileAsync.when(
                        data: (profile) => _ereceiptcard("Customer", profile?.fullName ?? "",isDark),
                        loading: () => _ereceiptcard("Customer", "",isDark),
                        error: (_,__) => _ereceiptcard("Customer", "",isDark),
                      ),                      /// STATUS
                      _ereceiptcard("Status", "Confirmed",isDark),

                      _ereceiptcard("Payment Method", order.paymentMethod,isDark),

                      _ereceiptcard("Address", order.address,isDark),

                      _ereceiptcard("Transaction ID", order.id,isDark),

                      _ereceiptcard("Date", order.date.toString(),isDark),

                      SizedBox(height: 24.h),

                      Text(
                        "Order Summary",
                        style: AppTypography.bodyLargeBold,
                      ),

                      SizedBox(height: 12.h),

                      _ereceiptcard("Amount", "\$${order.price}",isDark),

                      _ereceiptcard("Shipping", "\$${order.shipping}",isDark),

                      /// PROMO
                      _ereceiptcard("Promo", "\$0",isDark),

                      _ereceiptcard("Total", "\$${order.total}",isDark),

                      SizedBox(height: 40.h),

                      /// DOWNLOAD RECEIPT BUTTON
                      ActionButton(
                        text: "Download E-Receipt",
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Receipt downloaded"),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 24.h),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _ereceiptcard(String title, String value,bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTypography.bodySmallRegular.copyWith(
            color: AppColors.fontGrey
          )),
          Text(value, style: AppTypography.bodyMediumBold.copyWith(
            color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
          )),
        ],
      ),
    );
  }
}