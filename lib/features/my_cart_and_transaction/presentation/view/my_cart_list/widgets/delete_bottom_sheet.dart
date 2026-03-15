import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/shared_widgets/action_buttons/action_button.dart';
import 'package:plantify/core/theme/app_typography.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../domain/models/cart_model.dart';

class RemoveFromCartSheet extends StatelessWidget {
  final CartModel item;

  const RemoveFromCartSheet({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 78.h),
      decoration:  BoxDecoration(
color: isDark ? AppColors.dark500 : AppColors.white500,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Remove From Cart',
            style: AppTypography.bodyLargeBold.copyWith(
              color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
            )
          ),
          SizedBox(height: 24.h),

          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 120.w,
                  height: 120.h,
                  decoration: BoxDecoration(
color: isDark ? AppColors.fill01: AppColors.fill04,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: item.image.startsWith("http")
                      ? Image.network(
                    item.image,
                    fit: BoxFit.contain,
                  )
                      : Image.asset(
                    item.image,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: AppTypography.bodyLargeBold.copyWith(
                          color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                        )
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Size: ${item.size}   Qty: ${item.quantity}',
                        style: AppTypography.bodyNormalRegular.copyWith(
                          color: AppColors.fontGrey,
                        )
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: AppTypography.h6Bold.copyWith(
                          color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                        )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          Row(
            children: [
              Expanded(
                child: ActionButton(text: 'Cancel',
                onPressed: ()=> Navigator.pop(context),
    variant: ButtonVariant.line,
                  size: ButtonSize.medium,
                )
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: ActionButton(text: 'Yes Remove',
                onPressed: ()  => Navigator.pop(context, true),
size: ButtonSize.medium,
                  variant: ButtonVariant.primary,
    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}