import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color activeColor = AppColors.main500;
    final Color inactiveColor= AppColors.fontGrey;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    final iconPaths = [
      'assets/SvgIcons/home-03.svg',
      'assets/SvgIcons/shopping-cart-03.svg',
      'assets/SvgIcons/scan-svgrepo-com 1.svg',
      'assets/SvgIcons/shopping-bag-02.svg',
      'assets/SvgIcons/user-02.svg',
    ];

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        ClipPath(
          clipper: BottomNavClipper(),
          child: Container(
            height: 60.h + (bottomPadding > 0 ? bottomPadding : 12.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                if (!isDark)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10.r,
                    offset: const Offset(0, -2),
                  ),
              ],
            ),
            child: Padding(
    padding: EdgeInsets.fromLTRB(
    24.w,
    10.h, // small top padding
    24.w,
    bottomPadding > 0 ? bottomPadding : 14.h,
    ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left icons
                  Row(
                    children: [
                      _buildIcon(iconPaths[0], 0, currentIndex, onTap,
                          activeColor, inactiveColor),
                      SizedBox(width: 80.w),
                      _buildIcon(iconPaths[1], 1, currentIndex, onTap,
                          activeColor, inactiveColor),
                    ],
                  ),
                  // Right icons
                  Row(
                    children: [
                      _buildIcon(iconPaths[3], 3, currentIndex, onTap,
                          activeColor, inactiveColor),
                      SizedBox(width: 80.w),
                      _buildIcon(iconPaths[4], 4, currentIndex, onTap,
                          activeColor, inactiveColor),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // 🔸 Floating Scanner Button
        Positioned(
          top: -24.h,
          child: GestureDetector(
            onTap: () => onTap(2),
            child: Container(
              width: 52.w,
              height: 52.h,
              decoration:  ShapeDecoration(
                color: AppColors.main500,
                shape: OvalBorder(),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPaths[2],
                  width: 28.w,
                  height: 28.h,
                  colorFilter: const ColorFilter.mode(
                    AppColors.fill03,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(
      String path,
      int index,
      int currentIndex,
      ValueChanged<int> onTap,
      Color activeColor,
      Color inactiveColor,
      ) {
    final bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: SvgPicture.asset(
        path,
        width: 27.w,
        height: 27.h,
        colorFilter: ColorFilter.mode(
          isSelected ? activeColor : inactiveColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    const double curveRadius = 25;
    final double centerX = size.width / 2;

    path.lineTo(centerX - curveRadius * 2, 0);
    path.quadraticBezierTo(
      centerX - curveRadius,
      0,
      centerX - curveRadius * 0.8,
      curveRadius * 0.7,
    );
    path.arcToPoint(
      Offset(centerX + curveRadius * 0.8, curveRadius * 0.7),
      radius:  Radius.circular(50.r),
      clockwise: false,
    );
    path.quadraticBezierTo(
      centerX + curveRadius,
      0,
      centerX + curveRadius * 2,
      0,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
