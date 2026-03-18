import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class AiChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final bool isVoice;
  final String? userImage;
  final VoidCallback? onDelete;

  const AiChatBubble({
    super.key,
    required this.message,
    required this.isUser,
    this.isVoice = false,
    this.userImage,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (message.isEmpty && !isUser) return const SizedBox.shrink();

    return GestureDetector(
      onLongPress: () => _showDeleteSheet(context),
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Row(
          mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isUser) ...[_aiAvatar(isDark), SizedBox(width: 8.w)],
            Flexible(child: _buildBubble(isDark)),
            if (isUser) ...[SizedBox(width: 8.w), _userAvatar()],
          ],
        ),
      ),
    );
  }

  Widget _buildBubble(bool isDark) {
    if (isUser && isVoice) return _voiceBubble();
    if (isUser) return _userTextBubble();
    return _aiBubble(isDark);
  }

  Widget _voiceBubble() {
    const List<double> bars = [
      4, 8, 14, 20, 16, 24, 18, 26, 20, 28,
      22, 18, 24, 16, 20, 14, 18, 10, 14, 8,
      12, 6, 10, 8, 6, 10, 8, 12, 6, 8,
    ];

    return Container(
      constraints: BoxConstraints(minWidth: 180.w, maxWidth: 260.w),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.main500,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.r),
          topRight: Radius.circular(18.r),
          bottomLeft: Radius.circular(18.r),
          bottomRight: Radius.circular(4.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.main500.withOpacity(0.28),
            blurRadius: 8.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.mic_rounded, color: AppColors.fontWhite, size: 20.w),
          SizedBox(width: 10.w),

          Expanded(
            child: SizedBox(
              height: 30.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(bars.length, (i) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 1.w),
                    width: 3.w,
                    height: bars[i],
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userTextBubble() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.main500,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(4.r),
        ),
      ),
      child: Text(
        message,
        style: AppTypography.bodyMediumRegular.copyWith(color: AppColors.fontWhite),
      ),
    );
  }

  Widget _aiBubble(bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.grey.shade100,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
          bottomLeft: Radius.circular(4.r),
          bottomRight: Radius.circular(16.r),
        ),
      ),
      child: Text(
        message,
        style: AppTypography.bodyMediumRegular.copyWith(
          color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
        ),
      ),
    );
  }

  Widget _aiAvatar(bool isDark) => Container(
    width: 32.w,
    height: 32.w,
    decoration: BoxDecoration(
      color: isDark ? AppColors.fontBlack : AppColors.fontWhite,
      shape: BoxShape.circle,
    ),
    child:  Center(
      child: Text('🌿', style: TextStyle(fontSize: 16.sp)),
    ),
  );

  Widget _userAvatar() => CircleAvatar(
    radius: 16.r,
    backgroundColor: AppColors.main500,
    backgroundImage:
    userImage != null ? FileImage(File(userImage!)) : null,
    child: userImage == null
        ?  Icon(Icons.person, color: AppColors.fontWhite,size: 18.sp,)
        : null,
  );

  void _showDeleteSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text('Delete message'),
            onTap: () {
              Navigator.pop(context);
              onDelete?.call();
            },
          ),
        ),
      ),
    );
  }
}