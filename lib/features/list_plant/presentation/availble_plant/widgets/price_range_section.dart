import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';


class PriceRangeSection extends StatefulWidget {
  const PriceRangeSection({super.key});

  @override
  State<PriceRangeSection> createState() => _PriceRangeSectionState();
}

class _PriceRangeSectionState extends State<PriceRangeSection> {
  double minValue = 20;
  double maxValue = 100;

  final double minPrice = 0;
  final double maxPrice = 200;

  double _barLeft = 0;
  double _barWidth = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Price Range",
          style: AppTypography.bodyMediumBold.copyWith(
            color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
          )

        ),
        SizedBox(height: 12.h),

        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 76.w),
            child: SvgPicture.asset(
              'assets/SvgIcons/Bar Price.svg',
              width: 104.w,
              fit: BoxFit.contain,
            ),
          ),
        ),

        SizedBox(height: 0.h),

        LayoutBuilder(
          builder: (context, constraints) {
            _barWidth = constraints.maxWidth;

            final leftPos =
                (minValue - minPrice) / (maxPrice - minPrice) * _barWidth;

            final rightPos =
                (maxValue - minPrice) / (maxPrice - minPrice) * _barWidth;

            return GestureDetector(
              onHorizontalDragStart: (details) {
                final box =
                context.findRenderObject() as RenderBox;
                _barLeft = box.localToGlobal(Offset.zero).dx;
              },
              child: SizedBox(
                height: 13.h, // bigger touch area
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    /// Background
                    Container(
                      width: _barWidth,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.fill01 : AppColors.fill04,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),

                    Positioned(
                      left: leftPos,
                      child: Container(
                        width: rightPos - leftPos,
                        height: 12.h,
                        decoration: BoxDecoration(
color: AppColors.main500,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                    ),

                    Positioned(
                      left: leftPos - 12.w,
                      child: _sliderKnob(
                        onDrag: (globalX) {
                          final dx = globalX - _barLeft;
                          final value = (dx / _barWidth) *
                              (maxPrice - minPrice) +
                              minPrice;

                          setState(() {
                            minValue =
                                value.clamp(minPrice, maxValue);
                          });
                        },
                      ),
                    ),

                    Positioned(
                      left: rightPos - 12.w,
                      child: _sliderKnob(
                        onDrag: (globalX) {
                          final dx = globalX - _barLeft;
                          final value = (dx / _barWidth) *
                              (maxPrice - minPrice) +
                              minPrice;

                          setState(() {
                            maxValue =
                                value.clamp(minValue, maxPrice);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        SizedBox(height: 16.h),

        Row(
          children: [
            _priceBox("\$${minValue.toStringAsFixed(0)},00"),
            SizedBox(width: 38.w),
            Container(
              width: 25.w,
              height: 4.h,
              decoration: BoxDecoration(
color: AppColors.fontGrey,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            SizedBox(width: 38.w),
            _priceBox("\$${maxValue.toStringAsFixed(0)},00"),
          ],
        ),
      ],
    );
  }

  Widget _sliderKnob({required Function(double globalX) onDrag}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragUpdate: (details) {
        onDrag(details.globalPosition.dx);
      },
      child: Container(
        width: 28.w,
        height: 28.h,
        alignment: Alignment.center,
        child: Container(
          width: 18.w,
          height: 18.h,
          decoration: const BoxDecoration(
            color: AppColors.main500,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _priceBox(String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.fill01 : AppColors.fill04,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        text,
        style: AppTypography.bodyMediumBold.copyWith(
          color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
        )
      ),
    );
  }
}