class ProductUiModel {
  final String id;
  final String title;
  final String imagePath;
  final String category;
  final double price;
  final bool isLiked;

  ProductUiModel({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.category,
    required this.price,
    required this.isLiked,
  });

  ProductUiModel copyWith({
    bool? isLiked,
  }) {
    return ProductUiModel(
      id: id,
      title: title,
      imagePath: imagePath,
      category: category,
      price: price,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}