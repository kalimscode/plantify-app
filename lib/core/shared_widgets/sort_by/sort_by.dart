import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../action_buttons/radio_button.dart';

class SortByBottomSheet extends StatefulWidget {
  final String name; // e.g., "Sort By"
  final String selectedOption; // currently selected
  final ValueChanged<String> onOptionSelected;
  final List<String> options; // ✅ required list of names

  const SortByBottomSheet({
    Key? key,
    required this.name,
    required this.selectedOption,
    required this.onOptionSelected,
    required this.options, // ✅ new required parameter
  }) : super(key: key);

  @override
  State<SortByBottomSheet> createState() => _SortByBottomSheetState();
}

class _SortByBottomSheetState extends State<SortByBottomSheet> {
  late String _currentSelection;

  @override
  void initState() {
    super.initState();
    _currentSelection = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: ShapeDecoration(
        color: isDark ? AppColors.dark400 : AppColors.white500,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- small centered grabber / divider (60.w, fill01 color) ---
            Center(
              child: Container(
                width: 60.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.fill01,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
SizedBox(height: 26.h,),
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: AppTypography.bodyLargeBold.copyWith(
                    color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            ...widget.options.map((option) {
              final bool isActive = _currentSelection == option;
              return InkWell(
                onTap: () {
                  setState(() {
                    _currentSelection = option;
                  });
                  widget.onOptionSelected(option);
                  Navigator.pop(context);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        option,
                        style: AppTypography.bodyMediumBold.copyWith(
                          color: isDark
                              ? AppColors.fontWhite
                              : AppColors.fontBlack,
                        ),
                      ),
                      CustomRadioButton(
                        isActive: isActive,
                        onTap: () {
                          setState(() {
                            _currentSelection = option;
                          });
                          widget.onOptionSelected(option);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
