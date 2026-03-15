import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/providers.dart';
import '../../../../../core/shared_widgets/action_buttons/action_button.dart';
import '../../../../../core/shared_widgets/dialog/confirmation_dialog.dart';
import '../../../../../core/shared_widgets/form_fields/pin/pin_input_field.dart';
import '../../../../../core/shared_widgets/navigation/navigation1.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../router.dart';
import '../widget/pin_success_popup.dart';

class PinScreen extends ConsumerStatefulWidget {
final SuccessPopupFlow flow;

const PinScreen({super.key, required this.flow});

@override
ConsumerState<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends ConsumerState<PinScreen> {
Future<bool> _onBackPressed() async {
await showDialog(
context: context,
builder: (_) => ConfirmationDialog(
title: "Exit App",
message: "Do you want to exit?",
confirmText: "Exit",
cancelText: "Stay",
onConfirm: () {
Navigator.pushNamedAndRemoveUntil(
context,
AppRouter.welcome,
(route) => false,
);
},
),
);
return false;
}

@override
Widget build(BuildContext context) {
final viewModel = ref.watch(pinViewModelProvider);
final isDark = Theme.of(context).brightness == Brightness.dark;

return WillPopScope(
onWillPop: _onBackPressed,
child: Scaffold(
body: SafeArea(
child: Padding(
padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Navigation1(title: 'Enter Your Pin'),
SizedBox(height: 32.h),
Text(
'Add a PIN number to make your account more secure',
textAlign: TextAlign.center,
style: AppTypography.bodyNormalRegular.copyWith(
color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
),
),
SizedBox(height: 92.h),

Row(
mainAxisAlignment: MainAxisAlignment.center,
children: List.generate(
4,
(index) => Padding(
padding: EdgeInsets.symmetric(horizontal: 10.w),
child: FormPinField(
controller: viewModel.pinControllers[index],
onChanged: (val) => viewModel.onPinChanged(index, val),
),
),
),
),
SizedBox(height: 143.h),

/// BUTTONS
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
ActionButton(
text: 'Reset',
variant: ButtonVariant.line,
size: ButtonSize.medium,
onPressed: viewModel.resetPin,
),
SizedBox(width: 24.w),

ActionButton(
text: 'Continue',
size: ButtonSize.medium,
onPressed: () {
viewModel.onContinue();

showDialog(
context: context,
barrierDismissible: false,
builder: (_) =>
SuccessPopupWidget(flow: widget.flow),
);
},
),
],
),
],
),
),
),
),
);
}
}