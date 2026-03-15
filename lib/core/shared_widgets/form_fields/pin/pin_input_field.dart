import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';
import '../input_state/input_state.dart';

class FormPinField extends StatefulWidget {
final TextEditingController? controller;
final FocusNode? focusNode;
final ValueChanged<String>? onChanged;
final VoidCallback? onFilled;

const FormPinField({
Key? key,
this.controller,
this.focusNode,
this.onChanged,
this.onFilled,
}) : super(key: key);

@override
State<FormPinField> createState() => _FormPinFieldState();
}

class _FormPinFieldState extends State<FormPinField> {
InputState _state = InputState.defaultState;

@override
void initState() {
super.initState();
widget.focusNode?.addListener(() {
setState(() {
if (widget.focusNode!.hasFocus &&
(widget.controller?.text.isNotEmpty ?? false)) {
_state = InputState.typing;
} else if (!widget.focusNode!.hasFocus &&
(widget.controller?.text.isNotEmpty ?? false)) {
_state = InputState.filled;
} else {
_state = InputState.defaultState;
}
});
});
}

void _onChanged(String value) {
setState(() {
_state = value.isEmpty ? InputState.defaultState : InputState.filled;
});
widget.onChanged?.call(value);
if (value.isNotEmpty) widget.onFilled?.call();
}

@override
Widget build(BuildContext context) {
final isDark = Theme.of(context).brightness == Brightness.dark;

return GestureDetector(
onTap: () => FocusScope.of(context).requestFocus(widget.focusNode),
child: Container(
width: 55.w,
height: 55.h,
padding: EdgeInsets.symmetric(horizontal: 8.w),
decoration: BoxDecoration(
color: AppColors.fill04,
borderRadius: BorderRadius.circular(10.r),
border: Border.all(
color: widget.focusNode?.hasFocus == true
? AppColors.main500
    : Colors.transparent,
width: 1,
),
),
alignment: Alignment.center,
child: TextField(
focusNode: widget.focusNode,
controller: widget.controller,
onChanged: _onChanged,
maxLength: 1,
showCursor: true,
obscureText: true, // 👈 hides input
obscuringCharacter: '●', // 👈 dot instead of *
cursorColor: isDark ? AppColors.fontWhite : AppColors.fontBlack,
keyboardType: TextInputType.number,
textAlign: TextAlign.center,
style: AppTypography.bodyMediumMedium.copyWith(
color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
fontSize: 20.sp,
fontWeight: FontWeight.w700,
),
decoration: const InputDecoration(
counterText: '',
border: InputBorder.none,
isCollapsed: true,
),
),
),
);
}
}
