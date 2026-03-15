import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plantify/features/order_and_e-eeceipt/presentation/myorder_status/widgets/leave_review_sheet.dart';
import 'package:plantify/router.dart';
import '../../../../../core/di/providers.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../state/order_state.dart';
import '../../viewmodel/order_enum.dart';

class MyOrdersScreen extends ConsumerStatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  ConsumerState<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends ConsumerState<MyOrdersScreen> {

  OrderStatus _selectedStatus = OrderStatus.onProgress;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(orderProvider.notifier).loadOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final orderState = ref.watch(orderProvider);

    final orders = orderState.orders.map((e) {
      return OrderItem(
        id: e.id,
        date: e.date,
        productName: e.productName,
        image: e.image.isEmpty ? 'assets/images/plant1.png' : e.image,
        size: e.size,
        quantity: e.quantity,
        price: e.price,
        status: e.status == "completed"
            ? OrderStatus.success
            : OrderStatus.onProgress,
      );
    }).toList();

    final demoOrders = [
      OrderItem(
        id: "demo1",
        date: DateTime.now(),
        productName: "Snake Plant",
        image: "assets/images/plant1.png",
        size: "Medium",
        quantity: 1,
        price: 20,
        status: OrderStatus.onProgress,
      ),
      OrderItem(
        id: "demo2",
        date: DateTime.now().subtract(const Duration(days: 1)),
        productName: "Aloe Vera",
        image: "assets/images/plant1.png",
        size: "Small",
        quantity: 2,
        price: 15,
        status: OrderStatus.cancelled,
      ),
      OrderItem(
        id: "demo2",
        date: DateTime.now().subtract(const Duration(days: 1)),
        productName: "Aloe Vera",
        image: "assets/images/plant1.png",
        size: "Small",
        quantity: 2,
        price: 15,
        status: OrderStatus.success,
      ),
    ];

    /// Combine real + demo
    final allOrders = [...orders, ...demoOrders];

    final filteredOrders =
    allOrders.where((e) => e.status == _selectedStatus).toList();

    return Scaffold(
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
          child: Column(
            children: [
              _header(isDark),
              _tabs(isDark),
              Expanded(child: _orderList(filteredOrders)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(bool isDark) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 12.h),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/SvgIcons/shopping-bag-02.svg',
            width: 22.w,
            color: AppColors.main500,
          ),
          SizedBox(width: 10.w),
          Text('My Orders', style: AppTypography.h5Bold.copyWith(
            color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
          )),
        ],
      ),
    );
  }

  Widget _tabs(bool isDark) {
    return Container(
      height: 38.h,
      decoration: BoxDecoration(
color: isDark ? AppColors.fill01 : AppColors.fill04,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _tab(OrderStatus.onProgress, 'On Progress',isDark),
          _tab(OrderStatus.success, 'Success',isDark),
          _tab(OrderStatus.cancelled, 'Canceled',isDark),
        ],
      ),
    );
  }

  Widget _tab(OrderStatus status, String text,bool isDark) {
    final isSelected = _selectedStatus == status;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedStatus = status),
        child: Container(
          height: double.infinity,
          decoration: isSelected
              ? BoxDecoration(
            color: AppColors.main500,
            borderRadius: BorderRadius.circular(16.r),
          )
              : null,
          alignment: Alignment.center,
          child: Text(
            text,
            style: AppTypography.bodyLargeBold.copyWith(
              color: isSelected
                  ? AppColors.white500 // selected → always white
                  : (isDark
                  ? AppColors.fontWhite // unselected dark → white
                  : AppColors.fontGrey),
            )
          ),
        ),
      ),
    );
  }

  Widget _orderList(List<OrderItem> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          "No Orders",
          style: AppTypography.bodyMediumRegular,
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.only(top: 16.h),
      itemCount: orders.length,
      separatorBuilder: (_, __) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        return _orderCard(orders[index], Theme.of(context).brightness == Brightness.dark);
      },
    );
  }

  Widget _orderCard(OrderItem order,bool isDark) {
    final months = [
      '',
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [
            SvgPicture.asset(
              'assets/SvgIcons/calendar-date.svg',
              width: 16,
              color: AppColors.fontGrey,
            ),
            SizedBox(width: 8.w),
            Text(
              '${months[order.date.month]} ${order.date.day}, ${order.date
                  .year}',
              style: AppTypography.bodySmallMedium.copyWith(
                color: AppColors.fontGrey,
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [

              Container(
                width: 120.w,
                height: 120.h,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.fill01 : AppColors.fill04,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Image.asset(order.image),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(order.productName,
                        style: AppTypography.bodyMediumBold.copyWith(
                          color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                        )),

                    SizedBox(height: 4.h),

                    Text(
                      'Size: ${order.size} Qty: ${order.quantity}',
                      style: AppTypography.bodySmallRegular.copyWith(
                        color: AppColors.fontGrey,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    _statusChip(order,isDark),

                    SizedBox(height: 6.h),

                    Row(
                      children: [
                        Text(
                          '\$${order.price}',
                          style: AppTypography.bodyMediumBold.copyWith(
                            color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                          )
                        ),
                        const Spacer(),

                        if (order.status == OrderStatus.onProgress)
                          _inlineButton('Track Order')
                        else
                          if (order.status == OrderStatus.success)
                            _inlineButton('Leave Review'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// STATUS CHIP
  Widget _statusChip(OrderItem order,bool isDark) {
    if (order.status == OrderStatus.cancelled) {
      return Container(
        padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side:  BorderSide(width: 1, color: AppColors.danger500),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        child:  Text(
          'Canceled',
          style: AppTypography.bodySmallMedium.copyWith(
            color: AppColors.danger500,
          )
        )

      );
    }

    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: order.status == OrderStatus.onProgress
              ? AppColors.main500
              : AppColors.success500,
        ),
      ),
      child: Text(
        order.status == OrderStatus.onProgress
            ? 'On progress'
            : 'Completed',
        style: AppTypography.bodySmallMedium.copyWith(
          color: order.status == OrderStatus.onProgress
              ? AppColors.main500
              : AppColors.success500,
        ),
      ),
    );
  }

  Widget _inlineButton(String title) {
    return SizedBox(
      height: 32.h,
      child: ElevatedButton(
        onPressed: () {
          if (title == 'Track Order') {
            Navigator.pushNamed(context, AppRouter.ordertracking,

            );
          }

          if (title == 'Leave Review') {
            _showLeaveReviewSheet();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.main500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
        ),
        child: Text(
          title,
          style: AppTypography.bodySmallMedium.copyWith(
            color: AppColors.fontWhite,
          ),
        ),
      ),
    );
  }

  /// REVIEW SHEET
  void _showLeaveReviewSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LeaveReviewSheet(),
    );
  }

}