import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/shared_widgets/action_buttons/action_button.dart';
import 'package:plantify/core/shared_widgets/navigation/navigation1.dart';
import '../../../../../core/di/providers.dart';
import '../../../../../core/shared_widgets/action_buttons/radio_button.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../router.dart';
import '../../../../order_and_e-eeceipt/domain/entities/order_entity.dart';
import '../../../../setup_profile_pages/pin/presentation/widget/pin_success_popup.dart';

class CheckoutPaymentScreen extends ConsumerStatefulWidget {
  const CheckoutPaymentScreen({super.key});

  @override
  ConsumerState<CheckoutPaymentScreen> createState() =>
      _CheckoutPaymentScreenState();
}

class _CheckoutPaymentScreenState
    extends ConsumerState<CheckoutPaymentScreen> {
  int selectedIndex = 0;

  List<Map<String, String>> get payments {
    final list = <Map<String, String>>[
      {'title': 'PayPal', 'icon': 'assets/SvgIcons/paypal.svg'},
      // ✅ Apple Pay only on iOS
      if (Platform.isIOS)
        {'title': 'Apple Pay', 'icon': 'assets/SvgIcons/applepay.svg'},
      {
        'title': 'Mastercard •••• 4356',
        'icon': 'assets/SvgIcons/mastercard.svg'
      },
      {'title': 'Gopay', 'icon': 'assets/SvgIcons/gopay.svg'},
    ];
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final paymentList = payments; // evaluated once per build

    if (selectedIndex >= paymentList.length) selectedIndex = 0;

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 24.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Navigation1(title: 'Payment'),
            ),

            SizedBox(height: 32.h),

            // ── Payment options list ─────────────────────────────────────────
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: ListView.separated(
                  itemCount: paymentList.length,
                  separatorBuilder: (_, __) => SizedBox(height: 24.h),
                  itemBuilder: (context, index) {
                    final item = paymentList[index];
                    final selected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () => setState(() => selectedIndex = index),
                      child: Container(
                        height: 80.h,
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 2,
                            color: selected
                                ? AppColors.main500
                                : AppColors.white400,
                          ),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(item['icon']!, width: 42.w),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                item['title']!,
                                style: AppTypography.bodyMediumBold.copyWith(
                                  color: isDark
                                      ? AppColors.white500
                                      : AppColors.dark500,
                                ),
                              ),
                            ),
                            CustomRadioButton(isActive: selected),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ── Add New Payment ──────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: ActionButton(
                text: 'Add New Payment',
                variant: ButtonVariant.line,
                size: ButtonSize.full,
                onPressed: () =>
                    Navigator.pushNamed(context, AppRouter.addnewpayment),
              ),
            ),

            // ── Confirm button ───────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 24.h),
              child: ActionButton(
                text: 'Confirm Payment',
                variant: ButtonVariant.primary,
                size: ButtonSize.full,
                onPressed: () async {
                  final cart = ref.read(cartProvider);
                  final address = ref.read(addressProvider);

                  if (cart.items.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Cart is empty")),
                    );
                    return;
                  }

                  final order = OrderEntity(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    productName: cart.items.first.title,
                    image: cart.items.first.image,
                    size: cart.items.first.size,
                    quantity: cart.items.first.quantity,
                    price: cart.items.first.price,
                    shipping: cart.shipping,
                    total: cart.total,
                    paymentMethod: paymentList[selectedIndex]['title']!,
                    address: address?.address ?? "No address",
                    date: DateTime.now(),
                    status: "completed",
                  );

                  await ref.read(orderProvider.notifier).createOrder(order);

                  if (!mounted) return;
                  Navigator.pushNamed(
                    context,
                    AppRouter.pinScreen,
                    arguments: SuccessPopupFlow.paymentPin,
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