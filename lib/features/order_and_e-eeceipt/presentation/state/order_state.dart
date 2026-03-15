import '../../domain/entities/order_entity.dart';
import '../viewmodel/order_enum.dart';

class OrderState {
  final bool isLoading;
  final List<OrderEntity> orders;
  final OrderEntity? lastOrder;

  OrderState({
    required this.isLoading,
    required this.orders,
    this.lastOrder,
  });

  factory OrderState.initial() {
    return OrderState(
      isLoading: false,
      orders: [],
      lastOrder: null,
    );
  }

  OrderState copyWith({
    bool? isLoading,
    List<OrderEntity>? orders,
    OrderEntity? lastOrder,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      lastOrder: lastOrder ?? this.lastOrder,
    );
  }
}


class OrderItem {
  final String id;
  final DateTime date;
  final String productName;
  final String image;
  final String size;
  final int quantity;
  final double price;
  final OrderStatus status;
  final bool canLeaveReview;

  OrderItem({
    required this.id,
    required this.date,
    required this.productName,
    required this.image,
    required this.size,
    required this.quantity,
    required this.price,
    required this.status,
    this.canLeaveReview = false,
  });
}
