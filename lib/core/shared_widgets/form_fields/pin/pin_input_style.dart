import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../input_state/input_state.dart';

class FormPinStyle {
  final Color backgroundColor;
  final Color? borderColor;
  final Color textColor;
  final TextStyle textStyle;

  FormPinStyle({
    required this.backgroundColor,
    this.borderColor,
    required this.textColor,
    required this.textStyle,
  });

  static FormPinStyle getStyle(bool isDark, InputState state) {
    const bgLight = Color(0xFFF7F7F7);
    const bgDark = Color(0xFF181818);
    const green = Color(0xFF41644A);

    final text = isDark ? Colors.white : Colors.black;

    switch (state) {
      case InputState.defaultState:
        return FormPinStyle(
          backgroundColor: isDark ? bgDark : bgLight,
          textColor: text,
          textStyle: TextStyle(
            color: text,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist',
          ),
        );
      case InputState.typing:
        return FormPinStyle(
          backgroundColor: isDark ? bgDark : bgLight,
          borderColor: green,
          textColor: text,
          textStyle: TextStyle(
            color: text,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist',
          ),
        );
      case InputState.filled:
        return FormPinStyle(
          backgroundColor: isDark ? bgDark : bgLight,
          textColor: text,
          textStyle: TextStyle(
            color: text,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist',
          ),
        );
    }
  }
}
