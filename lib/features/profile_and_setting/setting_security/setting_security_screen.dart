import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';
import '../../../core/shared_widgets/action_buttons/action_button.dart';
import '../../../core/shared_widgets/action_buttons/toggle_switch.dart';
import '../../../core/shared_widgets/navigation/navigation1.dart';


class SettingSecurityScreen extends StatefulWidget {
  const SettingSecurityScreen({super.key});

  @override
  State<SettingSecurityScreen> createState() => _SettingSecurityScreenState();
}

class _SettingSecurityScreenState extends State<SettingSecurityScreen> {
  bool rememberMe = true;
  bool faceId = false;
  bool biometricId = true;
  bool googleAuth = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark? AppColors.dark500: AppColors.white500,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 32.h),
          child: Column(
            children: [
              Navigation1(title: 'Security'),
SizedBox(height: 24.h,),
              _securityItem(
                isDark: isDark,
                title: 'Remember Me',
                value: rememberMe,
                onChanged: (v) => setState(() => rememberMe = v),
              ),
              _securityItem(
                isDark: isDark,
                title: 'Face ID',
                value: faceId,
                onChanged: (v) => setState(() => faceId = v),
              ),
              _securityItem(
                isDark: isDark,
                title: 'Biometric ID',
                value: biometricId,
                onChanged: (v) => setState(() => biometricId = v),
              ),
              _securityItem(
                isDark: isDark,
                title: 'Google Authenticator',
                value: googleAuth,
                onChanged: (v) => setState(() => googleAuth = v),
              ),

              SizedBox(height: 32.h,),

              ActionButton(
                text: 'Change PIN',
                onPressed: () {
                  // TODO: Navigate to Change PIN
                },
              ),
              SizedBox(height: 16.h),
              ActionButton(
                text: 'Change Password',
                onPressed: () {
                  // TODO: Navigate to Change Password
                },
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _securityItem({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isDark,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTypography.bodyMediumMedium.copyWith(
                color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
              )
            ),
          ),
          ToggleSwitch(
        isActive: true,
          ),
        ],
      ),
    );
  }
}
