import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../state/order_state.dart';

class OrderViewModel extends StateNotifier<OrderState> {
  final OrderRepository repository;

  OrderViewModel(this.repository) : super(OrderState.initial());

  /// CREATE ORDER
  Future<void> createOrder(OrderEntity order) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.createOrder(order);

      final updatedOrders = [...state.orders, order];

      state = state.copyWith(
        isLoading: false,
        orders: updatedOrders,
        lastOrder: order,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  /// LOAD ORDERS
  Future<void> loadOrders() async {
    state = state.copyWith(isLoading: true);

    try {
      final orders = await repository.getOrders(1, 20);

      state = state.copyWith(
        isLoading: false,
        orders: orders,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }
}