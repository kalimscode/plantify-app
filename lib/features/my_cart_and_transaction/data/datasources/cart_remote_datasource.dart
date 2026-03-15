import 'package:dio/dio.dart';
import '../../../../core/storage/token_storage.dart';
import '../../domain/models/cart_model.dart';

class CartRemoteDataSource {
  final Dio dio;
  final TokenStorage tokenStorage;

  CartRemoteDataSource(this.dio, this.tokenStorage);

  Future<Options> _authOptions() async {
    final token = await tokenStorage.getAccessToken();

    return Options(
      headers: {
        "Authorization": "Bearer $token",
      },
    );
  }

  /// GET CART
  Future<List<CartModel>> getCart(int page, int limit) async {
    final res = await dio.get(
      "/cart",
      queryParameters: {
        "page": page,
        "limit": limit,
      },
      options: await _authOptions(),
    );

    final list = res.data["data"]["items"] as List;

    return list.map((e) => CartModel.fromJson(e)).toList();
  }

  /// ADD
  Future<void> addToCart(String productId, int quantity) async {
    await dio.post(
      "/cart",
      data: {
        "productId": productId,
        "quantity": quantity,
      },
      options: await _authOptions(),
    );
  }

  /// UPDATE
  Future<void> updateCart(
      String cartId,
      String productId,
      int quantity,
      ) async {
    await dio.put(
      "/cart/$cartId",
      data: {
        "productId": productId,
        "quantity": quantity,
      },
      options: await _authOptions(),
    );
  }

  /// DELETE
  Future<void> removeCart(String cartId) async {
    await dio.delete(
      "/cart/$cartId",
      options: await _authOptions(),
    );
  }
}