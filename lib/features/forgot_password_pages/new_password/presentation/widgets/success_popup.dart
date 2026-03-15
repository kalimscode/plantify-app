import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';
import '../../../../../router.dart';

class SuccessPopup extends StatelessWidget {
const SuccessPopup({super.key});

@override
Widget build(BuildContext context) {
final isDark = Theme.of(context).brightness == Brightness.dark;

return Dialog(
backgroundColor: Colors.transparent,
insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
child: Container(
width: 260.w,
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
padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 24.h),
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
Stack(
alignment: Alignment.center,
children: [
Image.asset(
'assets/SvgIcons/congratulation.png',
width: 66.666.w,
height: 82.473.h,
fit: BoxFit.contain,
),
Positioned(
child: SvgPicture.asset(
'assets/SvgIcons/check.svg',
width: 32.w,
height: 32.w,
),
),
],
),
SizedBox(height: 12.h),
SizedBox(
width: 246.w,
child: Text(
'Congratulation',
textAlign: TextAlign.center,
style: AppTypography.bodyLargeBold.copyWith(
color: Colors.white,
),
),
),
SizedBox(height: 12.h),
SizedBox(
width: 246.w,
child: Text(
'Congratulations, the password has been successfully updated. Please log back into your account.',
textAlign: TextAlign.center,
style: AppTypography.bodySmallBold.copyWith(
color: Colors.white,
height: 1.4,
),
),
),
],
),
),
SizedBox(height: 12.h),
GestureDetector(
onTap: () {
Navigator.pop(context);
Navigator.pushNamed(context, AppRouter.loginAccount);
},
child: Container(
width: double.infinity,
padding:
EdgeInsets.symmetric(horizontal: 32.w, vertical: 10.h),
alignment: Alignment.center,
child: Text(
'Login Now',
textAlign: TextAlign.center,
style: AppTypography.bodyLargeBold.copyWith(
  color:
  isDark ? AppColors.fontWhite : AppColors.fontBlack,),
),
),
),
],
),
),
);
}
}
