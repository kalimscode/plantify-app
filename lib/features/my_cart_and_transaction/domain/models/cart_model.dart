class CartModel {
  final String id;
  final String productId;
  final String title;
  final String image;
  final double price;
  final String size;
  final int quantity;

  CartModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.image,
    required this.price,
    required this.size,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {

    final product = json['product'] ?? {};

    return CartModel(
      id: json['_id'] ?? '',
      productId: product['_id'] ?? '',
      title: product['name'] ?? '',
      image: product['image'] ?? '',
      price: (product['price'] ?? 0).toDouble(),
      size: product['size'] ?? 'Medium',
      quantity: json['quantity'] ?? 1,
    );
  }

  CartModel copyWith({
    String? id,
    String? productId,
    String? title,
    String? image,
    double? price,
    String? size,
    int? quantity,
  }) {
    return CartModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }
}