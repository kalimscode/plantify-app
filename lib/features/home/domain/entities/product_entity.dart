class ProductEntity {
  final String id;
  final String name;
  final String? image;
  final double price;
  final String? category;

  ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    this.image,
    this.category,
  });
}