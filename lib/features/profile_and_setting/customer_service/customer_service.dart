import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/shared_widgets/navigation/navigation3.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class CustomerServiceScreen extends StatelessWidget {
  const CustomerServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 24.w,vertical: 32.h),
          child: Column(
            children: [
             Navigation3(title: 'Customer Service', leadingIconPath: 'assets/SvgIcons/arrow-narrow-left.svg',onLeadingTap:()=> Navigator.pop(context), trailingIconPath1: 'assets/SvgIcons/phone-call-01.svg', trailingIconPath2: ''),
                       SizedBox(height: 22.h),
          
                      // Chat messages
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            _buildCustomerMessage('Hello, good morning',isDark),
                            _buildCustomerMessage(
                                'I am customer service, is there anything I can help you with?',isDark),
                            _buildUserMessage(
                                'I have a problem when add Payment Methods'),
                            _buildUserMessage('Can you help me'),
                            _buildCustomerMessage('Of course',isDark),
                            _buildCustomerMessage(
                                'Can you tell me the problem you are having? so I can help solve it',isDark),
                        ]),
                      ),
                      // Input box
                      Container(
                        padding:
                         EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                        decoration: BoxDecoration(
color: isDark ? AppColors.fill01 : AppColors.fill04,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/SvgIcons/emoji-20.svg',
                              width: 24.w,
                              height: 24.h,
                              color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                            ),
                             SizedBox(width: 12.w),
                             Expanded(
                              child: Text(
                                'Type a message',
                                style: AppTypography.bodyNormalMedium.copyWith(
                                  color: AppColors.fontGrey
                                )
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/SvgIcons/attachment-01.svg',
                              width: 24.w,
                              height: 24.h,
                              color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                            ),
                             SizedBox(width: 12.w),
                            SvgPicture.asset(
                              'assets/SvgIcons/send-01.svg',
                              width: 24.w,
                              height: 24.h,
                              color: AppColors.main500,
                            ),
                          ],
                        ),
                      ),
                       SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),

    );
  }

  // Customer service messages
  Widget _buildCustomerMessage(String text,bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
color: isDark ? AppColors.fill01 : AppColors.fill04,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodyNormalMedium.copyWith(
                color: isDark ? AppColors.fontWhite : AppColors.fontBlack
              )
            ),
          ),
           SizedBox(width: 10.w),
           Text(
            '19:43',
            style: AppTypography.bodySmallRegular.copyWith(
              color: AppColors.fontGrey
            )
          ),
        ],
      ),
    );
  }

  // User messages
  Widget _buildUserMessage(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: AppColors.main500,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(4),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodyNormalMedium.copyWith(
                color: AppColors.fontWhite
              )
            ),
          ),
          SizedBox(width: 10.w),
           Text(
            '19:43',
            style: AppTypography.bodySmallRegular.copyWith(
              color: AppColors.fontGrey
            )
          ),
        ],
      ),
    );
  }
}
