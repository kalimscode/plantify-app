import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/theme/app_colors.dart';
import 'package:plantify/core/theme/app_typography.dart';

class PlantCategorySelector extends StatefulWidget {

  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String>? onCategorySelected;

  const PlantCategorySelector({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    this.onCategorySelected,
  }) : super(key: key);

  @override
  State<PlantCategorySelector> createState() => _PlantCategorySelectorState();
}

class _PlantCategorySelectorState extends State<PlantCategorySelector> {

  late String _selectedCategory;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            children: widget.categories.map((category) {

              final bool isSelected = _selectedCategory == category;

              return Padding(
                padding: EdgeInsets.only(right: 6.w),
                child: GestureDetector(
                  onTap: () {

                    setState(() {
                      _selectedCategory = category;
                    });

                    widget.onCategorySelected?.call(category);

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 12.h
                    ),
                    decoration: ShapeDecoration(
                      color: isSelected
                          ? AppColors.main500
                          : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: isSelected
                            ? BorderSide.none
                            : BorderSide(
                          width: 1,
                          color: isDark
                              ? AppColors.fill01
                              : AppColors.fill04,
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    child: Text(
                      category,
                      style: AppTypography.bodyMediumMedium.copyWith(
                        color: isSelected
                            ? AppColors.fontWhite
                            : (isDark
                            ? AppColors.fontWhite
                            : AppColors.fontBlack),
                      ),
                    ),
                  ),
                ),
              );

            }).toList(),
          ),
        ),
      ),
    );
  }
}