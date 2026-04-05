import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/shared_widgets/action_buttons/action_button.dart';
import '../../../core/di/providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../router.dart';
import '../help_center/help_center_faq/help_center_faq_screen.dart';


class ProfileMenuScreen extends ConsumerStatefulWidget {
  const ProfileMenuScreen({super.key});

  @override
  ConsumerState<ProfileMenuScreen> createState() => _ProfileMenuScreenState();
}

class _ProfileMenuScreenState extends ConsumerState<ProfileMenuScreen>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  Future<void> logout() async {
    await ref.read(userSessionProvider.notifier).logout();
    ref.invalidate(userProfileProvider);
    ref.invalidate(userAddressesProvider);
    ref.invalidate(homeViewModelProvider);
    ref.invalidate(cartProvider);

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouter.loginAccount,
          (route) => false,
    );
  }

  Future<void> _goToEditProfile() async {
    await Navigator.pushNamed(
      context,
      AppRouter.setupProfile,
      arguments: {'isEditMode': true},
    );
    ref.invalidate(userProfileProvider);
  }

  Future<void> _goToAddress() async {
    await Navigator.pushNamed(context, AppRouter.checkoutSelectAddress);
    ref.invalidate(userAddressesProvider);
  }

  Future<void> _goToAddNewAddress() async {
    await Navigator.pushNamed(context, AppRouter.addNewAddress);
    ref.invalidate(userAddressesProvider);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final profileAsync = ref.watch(userProfileProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: profileAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) =>
            const Center(child: Text("Error loading profile")),
            data: (profile) {
              if (profile == null) {
                return const Center(child: Text("No profile found"));
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),

                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/SvgIcons/user-02.svg',
                          width: 24.w,
                          height: 24.h,
                          color: AppColors.main500,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Profile',
                          style: AppTypography.h6Bold.copyWith(
                            color: isDark
                                ? AppColors.fontWhite
                                : AppColors.fontBlack,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.more_horiz,
                          color: isDark
                              ? AppColors.fontWhite
                              : AppColors.fontBlack,
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // ── Profile row ──────────────────────────────────────────
                    Row(
                      children: [
                        // Avatar — tappable → edit profile
                        GestureDetector(
                          onTap: _goToEditProfile,
                          child: CircleAvatar(
                            radius: 28.r,
                            backgroundImage: profile.imagePath != null
                                ? FileImage(File(profile.imagePath!))
                                : const AssetImage(
                                'assets/images/default_avatar.jpg')
                            as ImageProvider,
                          ),
                        ),

                        SizedBox(width: 12.w),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Name — tappable → edit profile
                              GestureDetector(
                                onTap: _goToEditProfile,
                                child: Text(
                                  profile.fullName,
                                  style: AppTypography.bodyMediumBold.copyWith(
                                    color: isDark
                                        ? AppColors.fontWhite
                                        : AppColors.fontBlack,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                profile.phone,
                                style: AppTypography.bodySmallRegular.copyWith(
                                  color: isDark
                                      ? AppColors.fontWhite
                                      : AppColors.fontBlack,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Edit icon → edit profile
                        GestureDetector(
                          onTap: _goToEditProfile,
                          child: SvgPicture.asset(
                            'assets/SvgIcons/edit-05.svg',
                            width: 20.w,
                            height: 20.h,
                            color: AppColors.main500,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // ── General ──────────────────────────────────────────────
                    _sectionTitle('General', isDark),

                    _menuItem(
                      isDark: isDark,
                      icon: 'assets/SvgIcons/file-02.svg',
                      title: 'My Order',
                      onTap: () =>
                          Navigator.pushNamed(context, AppRouter.orderstatus),
                    ),

                    _menuItem(
                      isDark: isDark,
                      icon: 'assets/SvgIcons/ticket-01.svg',
                      title: 'Voucher',
                      onTap: () =>
                          Navigator.pushNamed(context, AppRouter.voucherlist),
                    ),

                    SizedBox(height: 24.h),

                    // ── Account Setting ───────────────────────────────────────
                    _sectionTitle('Account Setting', isDark),

                    // ✅ Address — navigates to address screen and refreshes
                    _menuItem(
                      isDark: isDark,
                      icon: 'assets/SvgIcons/marker-pin-01.svg',
                      title: 'Address',
                      onTap: _goToAddress,
                    ),

                    _menuItem(
                      isDark: isDark,
                      icon: 'assets/SvgIcons/wallet-03.svg',
                      title: 'Payment Methods',
                      onTap: () =>
                          Navigator.pushNamed(context, AppRouter.addnewpayment),
                    ),

                    _darkModeItem(),

                    _menuItem(
                      isDark: isDark,
                      icon: 'assets/SvgIcons/log-out-01.svg',
                      title: 'Logout',
                      onTap: () => _showLogoutBottomSheet(context, isDark),
                    ),

                    SizedBox(height: 24.h),

                    // ── App Setting ───────────────────────────────────────────
                    _sectionTitle('App Setting', isDark),

                    _menuItem(
                      isDark: isDark,
                      icon: 'assets/SvgIcons/file-02.svg',
                      title: 'Language',
                      onTap: () => Navigator.pushNamed(
                          context, AppRouter.settinglanguage),
                    ),

                    _menuItem(
                      isDark: isDark,
                      icon: 'assets/SvgIcons/bell-03.svg',
                      title: 'Notification',
                      onTap: () => Navigator.pushNamed(
                          context, AppRouter.settingnotification),
                    ),

                    _menuItem(
                      isDark: isDark,
                      icon: 'assets/SvgIcons/shield-tick.svg',
                      title: 'Security',
                      onTap: () =>
                          Navigator.pushNamed(context, AppRouter.settingsecurity),
                    ),

                    SizedBox(height: 24.h),

                    // ── Support ───────────────────────────────────────────────
                    _sectionTitle('Support', isDark),

                    _menuItem(
                      isDark: isDark,
                      icon: 'assets/SvgIcons/help-circle.svg',
                      title: 'Help Center',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HelpCenterFaqScreen(),
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, bool isDark) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        title,
        style: AppTypography.bodyMediumBold.copyWith(
          color: AppColors.fontGrey,
        ),
      ),
    );
  }

  Widget _menuItem({
    required String icon,
    required String title,
    required bool isDark,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.fill01 : AppColors.fill04,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    icon,
                    width: 20.w,
                    height: 20.h,
                    colorFilter: const ColorFilter.mode(
                      AppColors.fontGrey,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.bodyNormalBold.copyWith(
                    color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.fontGrey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _darkModeItem() {
    final themeNotifier = ref.watch(themeProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 36.w,
        height: 36.h,
        decoration: BoxDecoration(
          color: isDark ? AppColors.fill01 : AppColors.fill04,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/SvgIcons/eye.svg',
            width: 20.w,
            height: 20.h,
            color: AppColors.fontGrey,
          ),
        ),
      ),
      title: Text(
        'Dark Mode',
        style: AppTypography.bodyNormalBold.copyWith(
          color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
        ),
      ),
      trailing: Switch(
        value: isDark,
        onChanged: (value) => themeNotifier.toggleTheme(value),
      ),
    );
  }

  void _showLogoutBottomSheet(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding:
        const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 55),
        decoration: ShapeDecoration(
          color: isDark ? AppColors.dark500 : AppColors.white500,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Logout',
              style: AppTypography.bodyLargeBold
                  .copyWith(color: AppColors.danger500),
            ),
            SizedBox(height: 12.h),
            Text(
              'Are you sure want to logout?',
              style: AppTypography.bodyNormalBold.copyWith(
                color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    text: 'Cancel',
                    onPressed: () => Navigator.pop(context),
                    variant: ButtonVariant.line,
                    size: ButtonSize.medium,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ActionButton(
                    text: 'Yes, Logout',
                    onPressed: () {
                      Navigator.pop(context);
                      logout();
                    },
                    variant: ButtonVariant.primary,
                    size: ButtonSize.medium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}