import '../../domain/models/cart_model.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_datasource.dart';

class CartRepositoryImpl implements CartRepository {

  final CartRemoteDataSource remote;

  CartRepositoryImpl(this.remote);

  @override
  Future<List<CartModel>> getCart(int page, int limit) {
    return remote.getCart(page, limit);
  }

  @override
  Future<void> addToCart(String productId, int quantity) {
    return remote.addToCart(productId, quantity);
  }

  @override
  Future<void> updateCart(
      String cartId,
      String productId,
      int quantity,
      ) {
    return remote.updateCart(cartId, productId, quantity);
  }

  @override
  Future<void> removeCart(String cartId) {
    return remote.removeCart(cartId);
  }
}