import '../../../../core/network/api_client.dart';
import '../../domain/entities/order_entity.dart';

class OrderRemoteDataSource {
  final ApiClient api;

  OrderRemoteDataSource(this.api);

  Future<void> createOrder(OrderEntity order) async {
    await api.dio.post(
      '/orders',
      data: {
        "productName": order.productName,
        "image": order.image,
        "size": order.size,
        "quantity": order.quantity,
        "price": order.price,
        "shipping": order.shipping,
        "total": order.total,
        "paymentMethod": order.paymentMethod,
        "address": order.address,
        "date": order.date.toIso8601String(),
        "status": order.status,
      },
    );
  }

  Future<dynamic> getOrders(int page, int limit) async {
    final res = await api.dio.get(
      '/orders',
      queryParameters: {
        'page': page,
        'limit': limit,
      },
    );
    return res.data;
  }

  Future<dynamic> getOrderById(String id) async {
    final res = await api.dio.get('/orders/$id');
    return res.data;
  }
}