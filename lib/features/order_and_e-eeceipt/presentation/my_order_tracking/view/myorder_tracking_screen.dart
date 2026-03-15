import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/features/order_and_e-eeceipt/presentation/my_order_tracking/widgets/orderinfocard.dart';
import 'package:plantify/features/order_and_e-eeceipt/presentation/my_order_tracking/widgets/tracking_steps.dart';
import 'package:plantify/features/order_and_e-eeceipt/presentation/my_order_tracking/widgets/tracking_timeline_item.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/shared_widgets/navigation/navigation1.dart';


class MyOrderTrackingScreen extends StatelessWidget {
  const MyOrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:24.w,vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Navigation1(
                title: 'Tracking',
                onBackPressed: () => Navigator.pop(context),
              ),

              SizedBox(height: 24.h),

              const OrderInfoCard(),

              SizedBox(height: 24.h),

              const TrackingSteps(),

              SizedBox(height: 16.h),

              Center(
                child: Text(
                  'Packet In Delivery',
                  style: AppTypography.bodyMediumBold.copyWith(
                    color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                  )
                ),
              ),

              SizedBox(height: 24.h),

              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (_, __) => const TrackingTimelineItem(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
