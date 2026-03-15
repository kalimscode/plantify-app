import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/shared_widgets/action_buttons/action_button.dart';
import 'package:plantify/features/my_cart_and_transaction/presentation/view/my_cart_list/widgets/cart_card.dart';
import '../../../../../../core/di/providers.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_typography.dart';
import '../../../../../../router.dart';


class MyCartListScreen extends ConsumerStatefulWidget {
  const MyCartListScreen({super.key});

  @override
  ConsumerState<MyCartListScreen> createState() =>
      _MyCartListScreenState();
}

class _MyCartListScreenState
    extends ConsumerState<MyCartListScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(cartProvider.notifier).loadCart();
    });
  }

  @override
  Widget build(BuildContext context) {

    final cartState = ref.watch(cartProvider);
    final notifier = ref.read(cartProvider.notifier);
    final items = cartState.items;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
      isDark ? AppColors.dark500 : AppColors.white500,

      body: Column(
        children: [

          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 52.h, 24.w, 0),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/SvgIcons/shopping-cart-03.svg',
                  width: 24.w,
                  color: AppColors.main500,
                ),
                SizedBox(width: 12.w),
                Text('My Cart', style: AppTypography.h5Bold.copyWith(
                  color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                )),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          Expanded(
            child: cartState.isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )

                : items.isEmpty
                ? Center(
              child: Text(
                "Your cart is empty",
                style: AppTypography.bodyMediumRegular.copyWith(
                  color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                )
              ),
            )

                : Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 16.w),

              child: ListView.separated(
                padding:
                EdgeInsets.only(bottom: 40.h),

                itemCount: items.length,

                separatorBuilder: (_, __) =>
                    SizedBox(height: 16.h),

                itemBuilder: (_, index) {

                  final item = items[index];

                  return CartCard(
                    title: item.title,
                    price: item.price,
                    size: item.size,
                    quantity: item.quantity,
                    image: item.image,

                    onDelete: () async {
                      await notifier.remove(item);
                    },

                    onIncrease: () async {
                      await notifier.increase(item);
                    },

    onDecrease: () async {
    await notifier.decrease(item);
    },
    );
    },
    ),
    ),
    ),
    SizedBox(height: 20.h),

          Padding(
            padding: EdgeInsets.fromLTRB(
              24.w,
              0,
              24.w,
              8.h + MediaQuery.of(context).padding.bottom,
            ),
            child: ActionButton(
              text: 'Continue',
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  AppRouter.checkoutBlankFullScreen,
                );
              },
            ),
          ),

    SizedBox(height: 40.h),

    ],
      ),

    );
  }
}