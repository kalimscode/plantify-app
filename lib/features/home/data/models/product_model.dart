import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.price,
    super.image,
    super.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      image: json['image'],
      category: json['category']?['name'],
    );
  }
}