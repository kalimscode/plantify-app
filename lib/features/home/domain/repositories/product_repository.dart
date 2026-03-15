import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts({
    int page,
    int limit,
    String? category,
    String? subcategory,
    String? price,
    String? sort,
  });

  Future<List<ProductEntity>> getBestSelling(int limit);

  Future<ProductEntity> getProductById(String id);
}
