import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/shared_widgets/action_buttons/action_checkbox.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';
import 'package:plantify/core/shared_widgets/action_buttons/action_button.dart';
import '../../../../../core/di/providers.dart';
import '../../../../../core/shared_widgets/dialog/confirmation_dialog.dart';
import '../../../../../core/shared_widgets/form_fields/app_input_field/app_input_field.dart';
import '../../../../../core/shared_widgets/navigation/navigation1.dart';
import '../../../../../core/shared_widgets/snackbar/app_snackbar.dart';
import '../../../../../router.dart';
import '../../../pin/presentation/widget/pin_success_popup.dart';


class AddNewAddressScreen extends ConsumerStatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  ConsumerState<AddNewAddressScreen> createState() =>
      _AddNewAddressScreenState();
}

class _AddNewAddressScreenState
    extends ConsumerState<AddNewAddressScreen> {
  late final TextEditingController emailCtrl;
  late final TextEditingController nameCtrl;
  late final TextEditingController addressCtrl;

  @override
  void initState() {
    super.initState();
    emailCtrl = TextEditingController();
    nameCtrl = TextEditingController();
    addressCtrl = TextEditingController();
  }

  Future<bool> _onBackPressed() async {
    await showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: "Exit Setup",
        message:
        "Your address is required to continue. Are you sure you want to exit?",
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

    ref.listen(addNewAddressProvider, (previous, next) {
      if (next.error != null) {
        AppSnackBar.show(
          context,
          message: next.error!,
          type: SnackBarType.error,
        );
      }
    });

    final vm = ref.watch(addNewAddressProvider);
    final notifier = ref.read(addNewAddressProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  child: Navigation1(title: 'Add New Address'),
                ),

                Container(
                  width: double.infinity,
                  height: 300.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Maps.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                /// FORM
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.dark500 : AppColors.white500,
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.r)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child:
                        Container(width: 70.w, height: 4.h, color: Colors.black),
                      ),
                      SizedBox(height: 18.h),

                      Center(
                        child: Text(
                          'Address Detail',
                          style: AppTypography.bodyLargeBold.copyWith(
                            color: isDark
                                ? AppColors.white500
                                : AppColors.dark500,
                          ),
                        ),
                      ),

                      SizedBox(height: 18.h),

                      AppInputField(
                        label: 'Name Address',
                        hintText: 'Home',
                        controller: nameCtrl,
                        onChanged: notifier.setNameAddress,
                      ),

                      SizedBox(height: 22.h),

                      AppInputField(
                        label: 'Address',
                        hintText:
                        'Snow street, San Francisco, California 93244',
controller: addressCtrl,
                        onChanged: notifier.setAddress,
                        trailingIconPath:
                        'assets/SvgIcons/marker-pin-01.svg',
                      ),

                      SizedBox(height: 22.h),

                      Row(
                        children: [
                          ActionCheckbox(
                            value: vm.isDefault,
                            onChanged: (_) => notifier.toggleDefault(),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'Make this as the default address',
                              style:
                              AppTypography.bodySmallRegular.copyWith(
                                color: isDark
                                    ? AppColors.white500
                                    : AppColors.dark500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 32.h),

                      /// ADD BUTTON
                      ActionButton(
                        text: vm.isLoading ? 'Adding...' : 'Add',
    onPressed: vm.isLoading
    ? null
        : () async {

    await notifier.submit();

    final updatedState = ref.read(addNewAddressProvider);

    if (updatedState.error == null) {

    if(context.mounted){

    AppSnackBar.show(
    context,
    message: "Address added successfully",
    type: SnackBarType.success,
    );

    Navigator.pushNamed(
    context,
    AppRouter.pinScreen,
    arguments: SuccessPopupFlow.addressPin,
    );
    }

    }
    },
                      ),

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}