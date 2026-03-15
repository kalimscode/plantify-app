import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<void> createOrder(OrderEntity order);
  Future<List<OrderEntity>> getOrders(int page, int limit);
  Future<OrderEntity?> getOrderById(String id);
}