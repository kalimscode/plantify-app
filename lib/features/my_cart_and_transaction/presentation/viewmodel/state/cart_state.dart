import '../../../domain/models/cart_model.dart';

class CartState {

  final List<CartModel> items;
  final double shipping;
  final bool isLoading;
  final bool isLocalMode;

  const CartState({
    this.items = const [],
    this.shipping = 0,
    this.isLoading = false,
    this.isLocalMode = false,
  });

  double get subtotal =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  double get total => subtotal + shipping;

  CartState copyWith({
    List<CartModel>? items,
    double? shipping,
    bool? isLoading,
    bool? isLocalMode,
  }) {
    return CartState(
      items: items ?? this.items,
      shipping: shipping ?? this.shipping,
      isLoading: isLoading ?? this.isLoading,
      isLocalMode: isLocalMode ?? this.isLocalMode,
    );
  }
}