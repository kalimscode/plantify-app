import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../input_state/input_state.dart';
import 'otpcode_input_style.dart';

class OtpCodeInputField extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const OtpCodeInputField({
    Key? key,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  State<OtpCodeInputField> createState() => _OtpCodeInputFieldState();
}

class _OtpCodeInputFieldState extends State<OtpCodeInputField> {
  InputState _state = InputState.defaultState;

  void _onFocusChange(bool hasFocus) {
    setState(() {
      if (hasFocus && (widget.controller?.text.isNotEmpty ?? false)) {
        _state = InputState.typing;
      } else if (!hasFocus && (widget.controller?.text.isNotEmpty ?? false)) {
        _state = InputState.filled;
      } else {
        _state = InputState.defaultState;
      }
    });
  }

  void _onChanged(String value) {
    setState(() {
      _state = value.isEmpty ? InputState.defaultState : InputState.typing;
    });
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final style = OtpCodeInputStyle.getStyle(isDark, _state);

    return FocusScope(
      child: Focus(
        onFocusChange: _onFocusChange,
        child: Container(
          width: 56.w,
          height: 56.h,
          decoration: BoxDecoration(
            color: style.backgroundColor,
            borderRadius: BorderRadius.circular(10.r),
            border: style.borderColor != null
                ? Border.all(color: style.borderColor!)
                : null,
          ),
          alignment: Alignment.center,
          child: TextField(
            controller: widget.controller,
            onChanged: _onChanged,
            maxLength: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            cursorColor: style.textColor,
            style: style.textStyle,
            decoration: const InputDecoration(
              counterText: "",
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
