import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';
import '../datasources/LocalProductDataSource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remote;
  final LocalProductDataSource local;

  ProductRepositoryImpl(this.remote, this.local);

  @override
  Future<List<ProductEntity>> getProducts({
    int page = 1,
    int limit = 10,
    String? category,
    String? subcategory,
    String? price,
    String? sort,
  }) async {
    try {
      final products = await remote.getProducts(
        page: page,
        limit: limit,
        category: category?.isEmpty == true ? null : category,
        subcategory: subcategory,
        price: price,
        sort: sort,
      );

      // 🔥 IF API RETURNS EMPTY → USE LOCAL
      if (products.isEmpty) {
        return local.getFallbackProducts();
      }

      return products;
    } catch (_) {
      return local.getFallbackProducts();
    }
  }

  @override
  Future<List<ProductEntity>> getBestSelling(int limit) {
    return remote.getBestSelling(limit);
  }

  @override
  Future<ProductEntity> getProductById(String id) {
    return remote.getProductById(id);
  }
}