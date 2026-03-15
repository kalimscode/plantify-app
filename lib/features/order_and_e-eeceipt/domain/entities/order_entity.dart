class OrderEntity {
  final String id;
  final String productName;
  final String image;
  final String size;
  final int quantity;
  final double price;
  final double shipping;
  final double total;
  final String paymentMethod;
  final String address;
  final DateTime date;
  final String status;

  OrderEntity({
    required this.id,
    required this.productName,
    required this.image,
    required this.size,
    required this.quantity,
    required this.price,
    required this.shipping,
    required this.total,
    required this.paymentMethod,
    required this.address,
    required this.date,
    required this.status,
  });

  factory OrderEntity.fromJson(Map<String, dynamic> json) {
    return OrderEntity(
      id: json['id'],
      productName: json['productName'],
      image: json['image'] ?? '',
      size: json['size'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      shipping: (json['shipping'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      paymentMethod: json['paymentMethod'],
      address: json['address'],
      date: DateTime.parse(json['date']),
      status: json['status'],
    );
  }
}