import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/shared_widgets/navigation/navigation1.dart';
import 'package:plantify/core/theme/app_typography.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../router.dart';

class HelpCenterContactUsScreen extends StatelessWidget {
  const HelpCenterContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
     
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 24.h),
          child: Column(
            children: [
              Navigation1(title: 'Help Center'),
              SizedBox(height: 18.h,),
              _tabs(context),
              SizedBox(height: 32.h),
              _contactItem(
                isDark: isDark,
                icon: 'assets/SvgIcons/whatsapp.svg',
                title: 'WhatsApp',
              ),
              SizedBox(height: 24.h),
              _contactItem(
                isDark: isDark,
                icon: 'assets/SvgIcons/twitter.svg',
                title: 'Twitter',
              ),
              SizedBox(height: 24.h),
              _contactItem(
                isDark: isDark,
                icon: 'assets/SvgIcons/mail-02.svg',
                title: 'Email',
              ),
              SizedBox(height: 24.h),
              _contactItem(
                isDark: isDark,
                icon: 'assets/SvgIcons/instagram.svg',
                title: 'Instagram',
              ),
              SizedBox(height: 24.h),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                      AppRouter.customerservice);
                },
                child: _contactItem(
                  isDark: isDark,
                  icon: 'assets/SvgIcons/headphones-02.svg',
                  title: 'Customer Service',
                ),
              ),
              SizedBox(height: 40.h),
        
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabs(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRouter.faq);
            },
            child: Column(
              children: [
                Text(
                  'FAQ',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyLargeBold.copyWith(
                    color: isDark
                        ? AppColors.fontWhite
                        : AppColors.fontBlack,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  height: 2.h,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.fontGrey
                        : const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'Contact us',
                textAlign: TextAlign.center,
                style: AppTypography.bodyLargeBold.copyWith(
                  color: AppColors.main500,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.main500,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _contactItem({
    required bool isDark,
    required String icon,
    required String title,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),

      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 24.w,
            height: 24.w,
            color: isDark? AppColors.fill03: AppColors.fill01,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: AppTypography.bodyMediumMedium.copyWith(
                color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
              )
            ),
          ),
        ],
      ),
    );
  }
}
