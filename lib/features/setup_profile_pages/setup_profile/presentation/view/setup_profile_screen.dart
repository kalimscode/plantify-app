import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/shared_widgets/action_buttons/action_button.dart';
import '../../../../../core/di/providers.dart';
import '../../../../../core/shared_widgets/dialog/confirmation_dialog.dart';
import '../../../../../core/shared_widgets/form_fields/app_input_field/app_input_field.dart';
import '../../../../../core/shared_widgets/navigation/navigation1.dart';
import '../../../../../core/shared_widgets/snackbar/app_snackbar.dart';
import '../../../../../router.dart';
import '../viewmodel/setup_profile_state.dart';

class SetupProfileScreen extends ConsumerStatefulWidget {
  final bool isEditMode; // ← add this
  const SetupProfileScreen({super.key, this.isEditMode = false});

  @override
  ConsumerState<SetupProfileScreen> createState() =>
      _SetupProfileScreenState();
}

class _SetupProfileScreenState
    extends ConsumerState<SetupProfileScreen> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _genderCtrl;

  bool _navigated = false;
  bool _controllersSynced = false;

  @override
  void initState() {
    super.initState();

    _nameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _genderCtrl = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(setupProfileViewModelProvider.notifier).loadProfile();
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _genderCtrl.dispose();
    super.dispose();
  }
  Future<bool> _onBackPressed() async {
    await showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: "Profile Setup Incomplete",
        message: "Your profile setup is not complete. Do you want to exit?",
        confirmText: "Exit",
        cancelText: "Stay",
        onConfirm: () {
          Navigator.pop(context); // close the dialog
          SystemNavigator.pop();  // ← close the app
        },
      ),
    );

    return false;
  }

  bool get _isFormValid {
    return _nameCtrl.text.trim().isNotEmpty &&
        _emailCtrl.text.trim().contains('@') &&
        _phoneCtrl.text.trim().length >= 7 &&
        _genderCtrl.text.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(setupProfileViewModelProvider);
    final notifier =
    ref.read(setupProfileViewModelProvider.notifier);

    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    ref.listen<SetupProfileState>(
      setupProfileViewModelProvider,
          (previous, next) {
        if (!_controllersSynced &&
            next.profile.fullName.isNotEmpty) {
          _controllersSynced = true;

          _nameCtrl.text = next.profile.fullName;
          _emailCtrl.text = next.profile.email;
          _phoneCtrl.text = next.profile.phone;///////////////
          _genderCtrl.text = next.profile.gender;
        }

        if (previous?.isSuccess != next.isSuccess && next.isSuccess && !_navigated) {
          AppSnackBar.show(context, message: "Profile saved successfully", type: SnackBarType.success);
          _navigated = true;

          if (widget.isEditMode) {
            Navigator.pop(context);
          } else {
            Navigator.pushReplacementNamed(context, AppRouter.addNewAddress);
          }

          notifier.resetSuccess();
        }
        if (next.error != null && previous?.error != next.error) {
          AppSnackBar.show(
              context, message: next.error!, type: SnackBarType.error);
          Future.microtask(() => notifier.clearError());
        }});
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor:
        isDark ? AppColors.dark500 : AppColors.white500,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 32.h,
            ),
            child: Column(
              children: [
                Navigation1(title: 'Fill Your Profile',
            onBackPressed:  () => _onBackPressed(),
                ),
                SizedBox(height: 32.h),

                GestureDetector(
                  onTap: notifier.pickImage,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 168.w,
                        height: 168.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.fill04,
                        ),
                        child: ClipOval(
                          child: state.profile.imagePath != null
                              ? Image.file(
                            File(state.profile.imagePath!),
                            fit: BoxFit.cover,
                          )
                              : Center(
                            child: SvgPicture.asset(
                              'assets/SvgIcons/user-02.svg',
                              width: 88.w,
                              height: 88.h,
                              color: AppColors.fontGrey,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8.h,
                        right: 8.w,
                        child: Container(
                          width: 28.w,
                          height: 28.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.fill03,
                          ),
                          padding: EdgeInsets.all(4.w),
                          child: SvgPicture.asset(
                            'assets/SvgIcons/edit-05.svg',
                            color: AppColors.main500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                AppInputField(
                  label: 'Full Name',
                  leadingIconPath: 'assets/SvgIcons/user-02.svg',
                  hintText: 'Type your name',
                  controller: _nameCtrl,
                  onChanged: notifier.setFullName,
                ),

                SizedBox(height: 24.h),

                AppInputField(
                  label: 'Email',
                  leadingIconPath: 'assets/SvgIcons/mail-02.svg',
                  hintText: 'example@yourdomain.com',
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: notifier.setEmail,
                ),

                SizedBox(height: 24.h),

                AppInputField(
                  label: 'No Phone',
                  leadingIconPath:
                  'assets/SvgIcons/phone-call-01.svg',
                  hintText: 'Type your phone number',
                  controller: _phoneCtrl,
                  keyboardType: TextInputType.phone,
                  onChanged: notifier.setPhone,
                ),

                SizedBox(height: 24.h),

                AppInputField(
                  label: 'Gender',
                  leadingIconPath: 'assets/SvgIcons/user-02.svg',
                  hintText: 'Enter your gender',
                  controller: _genderCtrl,
                  onChanged: notifier.setGender,
                ),

                SizedBox(height: 32.h),

                ActionButton(
                  text: state.isLoading
                      ? 'Submitting...'
                      : 'Submit',
                  onPressed: state.isLoading || !_isFormValid
                      ? null
                      : notifier.submit,
                ),

                SizedBox(height: 96.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
