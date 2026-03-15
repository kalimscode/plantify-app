import '../models/cart_model.dart';

abstract class CartRepository {

  Future<List<CartModel>> getCart(int page, int limit);

  Future<void> addToCart(String productId, int quantity);

  Future<void> updateCart(
      String cartId,
      String productId,
      int quantity,
      );

  Future<void> removeCart(String cartId);
}