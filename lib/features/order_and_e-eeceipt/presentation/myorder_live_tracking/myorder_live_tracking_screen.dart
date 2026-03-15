import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/theme/app_typography.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/theme/app_colors.dart';

class MyOrderLiveTrackingScreen extends ConsumerWidget {
  const MyOrderLiveTrackingScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final profileAsync = ref.watch(userProfileProvider);
    final selectedAddress = ref.watch(addressProvider);

    return Scaffold(
backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/Maps.png',
                width: double.infinity,
                height: 420.h,
                fit: BoxFit.cover,
              ),

              Positioned(
                top: 50.h,
                left: 16.w,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Icon(
                    Icons.arrow_back,
                    color: isDark? AppColors.fontBlack: AppColors.fontBlack,
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(border: Border.all(
                color: AppColors.fontGrey,
                width: 0.01,
              ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24.r),
                ),

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
color: isDark ? AppColors.fill01 : AppColors.fill04,
                          borderRadius: BorderRadius.circular(12.r),

                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/SvgIcons/truck-01.svg',
                            width: 24.w,
                            color: AppColors.main500,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#434324MX',
                              style: AppTypography.bodyMediumBold.copyWith(
                                color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                              )
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Kencana Kargo',
                              style: AppTypography.bodyNormalRegular.copyWith(
                                color: AppColors.fontGrey
                              )
                            ),
                          ],
                        ),
                      ),

                      _ActionIcon(
                        icon: 'assets/SvgIcons/message-dots-circle.svg',
                        isDark: isDark,
                      ),
                      SizedBox(width: 8.w),
                      _ActionIcon(
                        icon: 'assets/SvgIcons/phone-call-01.svg',
                        isDark: isDark,
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  Row(
                    children: [
                      _InfoItem(
                        title: 'Estimate delivery',
                        value: '20 feb, 2023',
                         valueColor: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                        isDark: isDark,
                      ),
                      SizedBox(width: 100.w,),
                      _InfoItem(
                        title: 'Status',
                        value: 'On Progress',
                        valueColor: AppColors.main500,
                        isDark : isDark,
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  Row(
                    children: [
                      Expanded(
                        child: _AddressItem(isDark: isDark,
                          title: 'From',
                          name: 'Anna Hana',
                          address:
                          'Plume street, san francisco california 93244',
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: profileAsync.when(
                          data: (profile) => _AddressItem(
                            title: 'To',
                            name: profile?.fullName ?? "",
                            address: selectedAddress?.address ?? "",
                            isDark: isDark,
                          ),
                          loading: () => _AddressItem(
                            title: 'To',
                            name: "",
                            address: "",
                            isDark: isDark,
                          ),
                          error: (_, __) => _AddressItem(
                            title: 'To',
                            name: "",
                            address: "",
                            isDark: isDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final String icon;
final bool isDark;
  const _ActionIcon({required this.icon,required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          icon,
          width: 20.w,
          color: isDark ? AppColors.fill04 : AppColors.fill01,
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  final bool isDark;


  const _InfoItem({
    required this.title,
    required this.value,
    required this.isDark,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.bodyNormalRegular.copyWith(
            color: AppColors.fontGrey
          )
        ),
        SizedBox(height: 6.h),
        Text(
          value,
          style: AppTypography.bodyMediumBold.copyWith(
            color: valueColor ?? (isDark ? AppColors.fontWhite : AppColors.fontBlack),
          ),
        ),
      ],
    );
  }
}

class _AddressItem extends StatelessWidget {
  final bool isDark;
  final String title;
  final String name;
  final String address;

  const _AddressItem({
    required this.title,
    required this.name,
    required this.address,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.bodyNormalRegular.copyWith(
            color: AppColors.fontGrey,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          name,
          style: AppTypography.bodyMediumBold.copyWith(
            color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
          )
        ),
        SizedBox(height: 4.h),
        Text(
          address,
          style: AppTypography.bodyNormalRegular.copyWith(
            color: AppColors.fontGrey
          )
        ),
      ],
    );
  }
}
