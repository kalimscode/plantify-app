import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantify/core/shared_widgets/navigation/navigation1.dart';
import '../../../../core/shared_widgets/action_buttons/radio_button.dart';
import '../../../core/shared_widgets/form_fields/app_input_field/app_input_field.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLang = 'English (UK)';

  final List<Map<String, String>> languages = [
    {'flag': 'assets/SvgIcons/uk.svg', 'name': 'English (UK)'},
    {'flag': 'assets/SvgIcons/us.svg', 'name': 'English (US)'},
    {'flag': 'assets/SvgIcons/indonesia.svg', 'name': 'Indonesia'},
    {'flag': 'assets/SvgIcons/rusia.svg', 'name': 'Russia'},
    {'flag': 'assets/SvgIcons/french.svg', 'name': 'French'},
    {'flag': 'assets/SvgIcons/chinese.svg', 'name': 'Chinese'},
    {'flag': 'assets/SvgIcons/japanese.svg', 'name': 'Japanese'},
    {'flag': 'assets/SvgIcons/germany.svg', 'name': 'Germany'},
    {'flag': 'assets/SvgIcons/netherland.svg', 'name': 'Netherlands'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final theme = Theme.of(context);
    final backgroundColor =
    theme.brightness == Brightness.dark ? AppColors.dark500 : AppColors.white500;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(24.h, 52.h, 24.h, 0.h),
        child: Column(
          children: [
            Navigation1(title: 'Language'),
            AppInputField(
              label: '',
              hintText: 'Search',
              leadingIconPath: 'assets/SvgIcons/search-sm.svg',
              trailingIconPath: 'assets/SvgIcons/filter-lines.svg',
            ),
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final lang = languages[index];
        
                  return LanguageItem(
                    flagAsset: lang['flag']!,
                    language: lang['name']!,
                    selected: selectedLang == lang['name'],
                    onTap: () {
                      setState(() {
                        selectedLang = lang['name']!;
                      });
        
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageItem extends StatelessWidget {

  final String flagAsset;
  final String language;
  final bool selected;
  final VoidCallback? onTap;

  const LanguageItem({
    Key? key,
    required this.flagAsset,
    required this.language,
    this.selected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        margin:  EdgeInsets.symmetric(vertical: 6.h),
        padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              flagAsset,
              width: 24.w,
              height: 18.h,
            ),
             SizedBox(width: 14.w),

            Expanded(
              child: Text(
                language,
                style: AppTypography.bodyNormalMedium.copyWith(
                  color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                ),
              ),
            ),

            CustomRadioButton(
              isActive: selected,
            ),
          ],
        ),
      ),
    );
  }
}