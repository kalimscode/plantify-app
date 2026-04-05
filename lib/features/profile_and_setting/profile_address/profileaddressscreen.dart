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
import '../../../../../router.dart';

class ProfileAddressScreen extends ConsumerStatefulWidget {
  const ProfileAddressScreen({super.key});

  @override
  ConsumerState<ProfileAddressScreen> createState() =>
      _ProfileAddressScreenState();
}

class _ProfileAddressScreenState extends ConsumerState<ProfileAddressScreen> {
  int _selectedIndex = 0;
  bool _initialised = false;

  Future<void> _addNewAddress() async {
    await Navigator.pushNamed(context, AppRouter.addNewAddress);
    ref.invalidate(userAddressesProvider);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final addressAsync = ref.watch(userAddressesProvider);
    final currentAddress = ref.read(addressProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
          24.w,
          12.h,
          24.w,
          24.h + MediaQuery.of(context).padding.bottom,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColors.dark500 : AppColors.white500,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ActionButton(
              text: 'Add New Address',
              variant: ButtonVariant.line,
              size: ButtonSize.full,
              onPressed: _addNewAddress,
            ),
            SizedBox(height: 10.h),
            ActionButton(
              text: 'Confirm Address',
              size: ButtonSize.full,
              onPressed: addressAsync.whenOrNull(
                data: (addresses) => addresses.isEmpty
                    ? null
                    : () {
                  ref.read(addressProvider.notifier).state =
                  addresses[_selectedIndex];
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Navigation1(title: 'Address'),
              const SizedBox(height: 32),

              Expanded(
                child: addressAsync.when(
                  loading: () =>
                  const Center(child: CircularProgressIndicator()),
                  error: (_, __) =>
                  const Center(child: Text("Error loading addresses")),
                  data: (addresses) {
                    if (!_initialised && addresses.isNotEmpty) {
                      _initialised = true;
                      if (currentAddress != null) {
                        final idx = addresses.indexWhere(
                              (a) => a.address == currentAddress.address,
                        );
                        if (idx != -1) _selectedIndex = idx;
                      }
                    }

                    if (addresses.isEmpty) {
                      return Center(
                        child: Text(
                          "No addresses yet.\nTap 'Add New Address' below.",
                          textAlign: TextAlign.center,
                          style: AppTypography.bodyNormalRegular
                              .copyWith(color: AppColors.fontGrey),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: addresses.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final address = addresses[index];
                        return GestureDetector(
                          onTap: () => setState(() => _selectedIndex = index),
                          child: _addressCard(
                            title: address.nameAddress,
                            addressText: address.address,
                            selected: _selectedIndex == index,
                            isDark: isDark,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
        color: selected ? AppColors.main500 : AppColors.fontGrey,
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
            colorFilter: ColorFilter.mode(
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
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                addressText,
                style: AppTypography.bodyNormalRegular
                    .copyWith(color: AppColors.fontGrey),
              ),
            ],
          ),
        ),
        CustomRadioButton(isActive: selected),
      ],
    ),
  );
}