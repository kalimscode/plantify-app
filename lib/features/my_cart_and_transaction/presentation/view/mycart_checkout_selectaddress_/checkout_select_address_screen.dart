import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/shared_widgets/action_buttons/radio_button.dart';
import 'package:plantify/core/shared_widgets/navigation/navigation1.dart';
import 'package:plantify/core/shared_widgets/action_buttons/action_button.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';
import '../../../../../core/di/providers.dart';

class CheckoutSelectAddressScreen extends ConsumerStatefulWidget {
  const CheckoutSelectAddressScreen({super.key});

  @override
  ConsumerState<CheckoutSelectAddressScreen> createState() =>
      _CheckoutSelectAddressScreenState();
}

class _CheckoutSelectAddressScreenState
    extends ConsumerState<CheckoutSelectAddressScreen> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final addressAsync = ref.watch(userAddressesProvider);

    return Scaffold(
backgroundColor: isDark? AppColors.dark500: AppColors.white500,
      bottomNavigationBar: addressAsync.when(
        data: (addresses) {
          if (addresses.isEmpty) return const SizedBox();

          return Container(
            padding: EdgeInsets.fromLTRB(
              24,
              16,
              24,
              32 + MediaQuery
                  .of(context)
                  .padding
                  .bottom,
            ),
            child: ActionButton(
              text: 'Confirm Address',
              size: ButtonSize.full,
              onPressed: () {
                final selectedAddress = addresses[selectedIndex];

                ref
                    .read(addressProvider.notifier)
                    .state = selectedAddress;

                Navigator.pop(context);
              },
            ),
          );
        },
        loading: () => const SizedBox(),
        error: (_, __) => const SizedBox(),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                 const SizedBox(height: 16),

                Navigation1(title: 'Address'),

               const   SizedBox(height: 32),

                Expanded(
                  child: addressAsync.when(
                    loading: () =>
                    const Center(child: CircularProgressIndicator()),

                    error: (_, __) =>
                    const Center(child: Text("Error loading addresses")),

                    data: (addresses) {
                      if (addresses.isEmpty) {
                        return const Center(
                          child: Text("No addresses"),
                        );
                      }

                      return ListView.separated(
                        itemCount: addresses.length + 1,
                        separatorBuilder: (_, __) =>
                        const SizedBox(height: 24),

                        itemBuilder: (context, index) {
                          if (index == addresses.length) {
                            return ActionButton(
                              text: 'Add New Address',
                              variant: ButtonVariant.line,
                              size: ButtonSize.full,
                            );
                          }

                          final address = addresses[index];

                          return GestureDetector(
                            onTap: () {
                              setState(() => selectedIndex = index);
                            },
                            child: _addressCard(
                              title: address.nameAddress,
                              addressText: address.address,
                              selected: selectedIndex == index,
                              isDark: isDark
                            ),
                          );
                        },
                      );
                    },

                  ),
                ),
              ]),
        ),
      ),
    );
  }
  }

  /// ADDRESS CARD
  Widget _addressCard({
    required String title,
    required String addressText,
    required bool selected,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          width: 2.w,
          color: selected
              ?  AppColors.main500
              : AppColors.fontGrey,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 64.w,
            height: 68.h,
            decoration: BoxDecoration(
              color: isDark ? AppColors.fill01 : AppColors.fill04,
              borderRadius: BorderRadius.circular(16.r),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/SvgIcons/marker-pin-01.svg',
              width: 24.w,
              height: 24.h,
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
                  title,
                  style: AppTypography.bodyMediumBold.copyWith(
                    color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                  )
                ),
                 SizedBox(height: 6.h),
                Text(
                  addressText,
                  style: AppTypography.bodyNormalRegular.copyWith(color: AppColors.fontGrey),
                ),
              ],
            ),
          ),

          CustomRadioButton(isActive: selected),
        ],
      ),
    );
  }



