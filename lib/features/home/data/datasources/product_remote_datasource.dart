import '../../../../core/network/api_client.dart';
import '../models/product_model.dart';

class ProductRemoteDataSource {
  final ApiClient api;

  ProductRemoteDataSource(this.api);

  Future<List<ProductModel>> getProducts({
    int page = 1,
    int limit = 10,
    String? category,
    String? subcategory,
    String? price,
    String? sort,
  }) async {
    final res = await api.dio.get(
      '/products',
      queryParameters: {
        'page': page,
        'limit': limit,
        if (category != null) 'category': category,
        if (subcategory != null) 'subcategory': subcategory,
        if (price != null) 'price': price,
        if (sort != null) 'sort': sort,
      },
    );

    final List data = res.data['data'];

    return data.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<List<ProductModel>> getBestSelling(int limit) async {
    final res = await api.dio.get(
      '/products/best-selling',
      queryParameters: {'limit': limit},
    );

    final List data = res.data['data'];
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<ProductModel> getProductById(String id) async {
    final res = await api.dio.get('/products/$id');
    return ProductModel.fromJson(res.data['data']);
  }
}