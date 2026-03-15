import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_datasource.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remote;

  OrderRepositoryImpl(this.remote);

  @override
  Future<void> createOrder(OrderEntity order) async {
    try {
      await remote.createOrder(order);
    } catch (_) {
      /// If API fails we still allow local order
    }
  }

  @override
  Future<List<OrderEntity>> getOrders(int page, int limit) async {
    final data = await remote.getOrders(page, limit);

    if (data == null || data['data'] == null) {
      return [];
    }

    final list = data['data'] as List;

    return list.map((e) => OrderEntity.fromJson(e)).toList();
  }

  @override
  Future<OrderEntity?> getOrderById(String id) async {
    final data = await remote.getOrderById(id);

    if (data == null || data['data'] == null) return null;

    return OrderEntity.fromJson(data['data']);
  }
}