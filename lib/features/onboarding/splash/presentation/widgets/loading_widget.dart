import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/theme/app_colors.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double baseSize = 42.w;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final rotation = _controller.value * 2 * pi;
        return Transform.rotate(
          angle: rotation,
          child: SizedBox(
            width: baseSize,
            height: baseSize,
            child: Stack(
              children: List.generate(_dotPositions.length, (index) {
                final pos = _dotPositions[index];
                return Positioned(
                  top: pos['top']!.h,
                  left: pos['left']!.w,
                  child: Container(
                    width: pos['size']!.w,
                    height: pos['size']!.w,
                    decoration: const BoxDecoration(
                      color: AppColors.fill03,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

final List<Map<String, double>> _dotPositions = [
  {'top': 36.11, 'left': 19.04, 'size': 5.89},
  {'top': 0.0, 'left': 17.07, 'size': 9.83},
  {'top': 5.49, 'left': 5.49, 'size': 8.84},
  {'top': 31.6, 'left': 31.6, 'size': 4.91},
  {'top': 18.06, 'left': 0.98, 'size': 7.86},
  {'top': 20.02, 'left': 37.09, 'size': 3.93},
  {'top': 30.61, 'left': 6.47, 'size': 6.88},
  {'top': 8.44, 'left': 32.58, 'size': 2.95},
];
