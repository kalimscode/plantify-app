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
  final bool isEditMode;

  const SetupProfileScreen({super.key, this.isEditMode = false});

  @override
  ConsumerState<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends ConsumerState<SetupProfileScreen> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _genderCtrl;

  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _genderCtrl = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(setupProfileViewModelProvider.notifier).loadProfile();
      if (!mounted) return;
      _syncControllers();
    });
  }

  void _syncControllers() {
    final profile = ref.read(setupProfileViewModelProvider).profile;
    if (profile.fullName.isEmpty) return;

    _nameCtrl.text = profile.fullName;
    _emailCtrl.text = profile.email;
    _phoneCtrl.text = profile.phone;
    _genderCtrl.text = profile.gender;

    final n = ref.read(setupProfileViewModelProvider.notifier);
    n.setFullName(profile.fullName);
    n.setEmail(profile.email);
    n.setPhone(profile.phone);
    n.setGender(profile.gender);
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
    if (widget.isEditMode) {
      Navigator.pop(context);
      return false;
    }

    await showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: "Profile Setup Incomplete",
        message: "Your profile setup is not complete. Do you want to exit?",
        confirmText: "Exit",
        cancelText: "Stay",
        onConfirm: () {
          Navigator.pop(context);
          SystemNavigator.pop();
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
    final notifier = ref.read(setupProfileViewModelProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref.listen<SetupProfileState>(
      setupProfileViewModelProvider,
          (previous, next) {
        if (next.error != null && previous?.error != next.error) {
          AppSnackBar.show(context, message: next.error!, type: SnackBarType.error);
          Future.microtask(() => notifier.clearError());
        }

        if (previous?.isSuccess != next.isSuccess && next.isSuccess && !_navigated) {
          _navigated = true;

          AppSnackBar.show(
            context,
            message: "Profile saved successfully",
            type: SnackBarType.success,
          );

          ref.invalidate(userProfileProvider);

          if (widget.isEditMode) {
            Navigator.pop(context);
          } else {
            Navigator.pushReplacementNamed(context, AppRouter.mainWrapper);
          }

          notifier.resetSuccess();
        }
      },
    );

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              children: [
                Navigation1(
                  title: widget.isEditMode ? 'Edit Profile' : 'Fill Your Profile',
                  onBackPressed: () => _onBackPressed(),
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
                  onChanged: (v) {
                    notifier.setFullName(v);
                    setState(() {}); // revalidate form button
                  },
                ),

                SizedBox(height: 24.h),

                AppInputField(
                  label: 'Email',
                  leadingIconPath: 'assets/SvgIcons/mail-02.svg',
                  hintText: 'example@yourdomain.com',
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (v) {
                    notifier.setEmail(v);
                    setState(() {});
                  },
                ),

                SizedBox(height: 24.h),

                AppInputField(
                  label: 'No Phone',
                  leadingIconPath: 'assets/SvgIcons/phone-call-01.svg',
                  hintText: 'Type your phone number',
                  controller: _phoneCtrl,
                  keyboardType: TextInputType.phone,
                  onChanged: (v) {
                    notifier.setPhone(v);
                    setState(() {});
                  },
                ),

                SizedBox(height: 24.h),

                AppInputField(
                  label: 'Gender',
                  leadingIconPath: 'assets/SvgIcons/user-02.svg',
                  hintText: 'Enter your gender',
                  controller: _genderCtrl,
                  onChanged: (v) {
                    notifier.setGender(v);
                    setState(() {});
                  },
                ),

                SizedBox(height: 32.h),

                ActionButton(
                  text: state.isLoading ? 'Submitting...' : 'Submit',
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