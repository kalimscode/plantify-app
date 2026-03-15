import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';
import '../input_state/input_state.dart';

class AppInputField extends StatefulWidget {
  final String label;
  final String hintText;
  final String? leadingIconPath;
  final String? trailingIconPath;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTrailingIconTap; // ✔ NEW
  final bool isPassword;
  final TextInputType keyboardType;

  const AppInputField({
    Key? key,
    this.label = "Label",
    this.hintText = "Enter text here",
    this.leadingIconPath,
    this.trailingIconPath,
    this.controller,
    this.onChanged,
    this.onTrailingIconTap, // ✔ NEW
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  late TextEditingController _controller;
  InputState _state = InputState.defaultState;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    _controller.addListener(() {
      final value = _controller.text;
      if (value.isEmpty) {
        setState(() => _state = InputState.defaultState);
      } else if (_controller.selection.baseOffset != -1) {
        setState(() => _state = InputState.typing);
      }
      widget.onChanged?.call(value);
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _handleFocus(bool hasFocus) {
    setState(() {
      if (hasFocus && _controller.text.isNotEmpty) {
        _state = InputState.typing;
      } else if (!hasFocus && _controller.text.isNotEmpty) {
        _state = InputState.filled;
      } else {
        _state = InputState.defaultState;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = isDark ? AppColors.fill01 : AppColors.fill04;
    final Color borderColor =
    _state == InputState.typing ? AppColors.main500 : Colors.transparent;
    final Color iconColor = _state == InputState.typing
        ? (isDark ? AppColors.fontWhite : AppColors.fontBlack)
        : AppColors.fontGrey;
    final Color textColor = isDark ? AppColors.fontWhite : AppColors.fontBlack;
    final Color hintColor = AppColors.fontGrey;
    final Color labelColor = isDark ? AppColors.fontGrey : AppColors.fontBlack;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// LABEL
        Text(
          widget.label,
          style: AppTypography.bodyMediumMedium.copyWith(color: labelColor),
        ),
        SizedBox(height: 8.h),

        /// INPUT FIELD
        FocusScope(
          child: Focus(
            onFocusChange: _handleFocus,
            child: Container(
              height: 56.h,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: borderColor, width: 1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  /// LEADING ICON
                  if (widget.leadingIconPath != null) ...[
                    SvgPicture.asset(
                      widget.leadingIconPath!,
                      width: 24.w,
                      height: 24.w,
                      color: iconColor,
                    ),
                    SizedBox(width: 12.w),
                  ],

                  /// TEXT FIELD
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      obscureText: widget.isPassword ? _obscureText : false,
                      keyboardType: widget.keyboardType,
                      cursorColor: AppColors.main500,
                      style: AppTypography.bodyNormalMedium
                          .copyWith(color: textColor),
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: AppTypography.bodyNormalMedium
                            .copyWith(color: hintColor),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  /// TRAILING ICON
                  if (widget.isPassword)
                    GestureDetector(
                      onTap: () {
                        setState(() => _obscureText = !_obscureText);
                      },
                      child: SvgPicture.asset(
                        'assets/SvgIcons/eye-off.svg',
                        width: 24.w,
                        height: 24.h,
                        color: iconColor,
                      ),
                    )
                  else if (widget.trailingIconPath != null)
                    GestureDetector(
                      onTap: widget.onTrailingIconTap, // ✔ NEW
                      child: SvgPicture.asset(
                        widget.trailingIconPath!,
                        width: 24.w,
                        height: 24.h,
                        color: iconColor,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
