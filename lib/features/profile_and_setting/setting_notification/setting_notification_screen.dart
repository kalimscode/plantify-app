import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/shared_widgets/action_buttons/toggle_switch.dart';
import 'package:plantify/core/shared_widgets/navigation/navigation1.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';

class SettingNotificationScreen extends StatefulWidget {
  const SettingNotificationScreen({super.key});

  @override
  State<SettingNotificationScreen> createState() =>
      _SettingNotificationScreenState();
}

class _SettingNotificationScreenState
    extends State<SettingNotificationScreen> {
  bool appUpdate = true;
  bool cashback = true;
  bool generalNotification = true;
  bool newService = true;
  bool payment = false;
  bool promo = false;
  bool sound = true;
  bool specialOffers = true;
  bool vibrate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 32.h),
          child: Column(
            children: [
              Navigation1(title: 'Notification'),
              SizedBox(height: 24.h,),
              _NotificationTile(
                title: 'App Update',
                value: appUpdate,
                onChanged: (v) => setState(() => appUpdate = v),
              ),
              _NotificationTile(
                title: 'CashBack',
                value: cashback,
                onChanged: (v) => setState(() => cashback = v),
              ),
              _NotificationTile(
                title: 'General Notification',
                value: generalNotification,
                onChanged: (v) => setState(() => generalNotification = v),
              ),
              _NotificationTile(
                title: 'New Service Available',
                value: newService,
                onChanged: (v) => setState(() => newService = v),
              ),
              _NotificationTile(
                title: 'Payment',
                value: payment,
                onChanged: (v) => setState(() => payment = v),
              ),
              _NotificationTile(
                title: 'Promo and Discount',
                value: promo,
                onChanged: (v) => setState(() => promo = v),
              ),
              _NotificationTile(
                title: 'Sound',
                value: sound,
                onChanged: (v) => setState(() => sound = v),
              ),
              _NotificationTile(
                title: 'Spesial Offers',
                value: specialOffers,
                onChanged: (v) => setState(() => specialOffers = v),
              ),
              _NotificationTile(
                title: 'Vibrate',
                value: vibrate,
                onChanged: (v) => setState(() => vibrate = v),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _NotificationTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _NotificationTile({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(bottom: 24.w),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTypography.bodyMediumMedium
                  .copyWith(color: isDark ? AppColors.fontWhite : AppColors.fontBlack),
            ),
          ),
          ToggleSwitch(isActive: value, onTap: () => onChanged(!value),isDarkMode: isDark,),
        ],
      ),
    );
  }
}
