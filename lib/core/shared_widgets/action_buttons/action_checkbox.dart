import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/theme/app_colors.dart';

class ActionCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const ActionCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<ActionCheckbox> createState() => _ActionCheckboxState();
}

class _ActionCheckboxState extends State<ActionCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 24.w,
        height: 24.h,
        decoration: BoxDecoration(
          color: widget.value ? AppColors.main500: Colors.transparent,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: AppColors.main500,
            width: 1.w,
          ),
        ),
        child: widget.value
            ? Icon(Icons.check, color: AppColors.fill04, size: 16.sp)
            : null,
      ),
    );
  }
}
