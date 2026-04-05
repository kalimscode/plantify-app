import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../home/presentation/model/product_ui_model.dart';
import '../../../domain/models/cart_model.dart';
import '../../../domain/repositories/cart_repository.dart';
import '../state/cart_state.dart';

class CartNotifier extends StateNotifier<CartState> {

  final CartRepository repository;

  CartNotifier(this.repository) : super(const CartState());

  /// LOCAL MEMORY CART
  List<CartModel> _localCart = [];

  /// LOAD CART
  Future<void> loadCart() async {

    try {

      state = state.copyWith(isLoading: true);

      final apiItems = await repository.getCart(1, 20);

      /// API EMPTY → LOCAL MODE
      if (apiItems.isEmpty) {

        state = state.copyWith(
          items: _localCart,
          isLocalMode: true,
          isLoading: false,
        );

      } else {

        state = state.copyWith(
          items: apiItems,
          isLocalMode: false,
          isLoading: false,
        );
      }

    } catch (e) {

      /// API FAILED → LOCAL MODE
      state = state.copyWith(
        items: _localCart,
        isLocalMode: true,
        isLoading: false,
      );

      print("LOAD CART ERROR: $e");
    }
  }

  /// ADD TO CART
  Future<void> addToCart(ProductUiModel product, int quantity) async {

    /// LOCAL MODE
    if (state.isLocalMode) {

      final index = _localCart.indexWhere(
              (e) => e.productId == product.id);

      if (index != -1) {

        _localCart[index] = _localCart[index].copyWith(
          quantity: _localCart[index].quantity + quantity,
        );

      } else {

        _localCart.add(
          CartModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            productId: product.id,
            title: product.title,
            image: product.imagePath,
            price: product.price,
            size: "Medium",
            quantity: quantity,
          ),
        );
      }

      state = state.copyWith(items: [..._localCart]);

      return;
    }

    /// API MODE
    try {

      await repository.addToCart(product.id, quantity);

      await loadCart();

    } catch (e) {

      print("ADD CART ERROR: $e");

    }
  }

  /// INCREASE
  Future<void> increase(CartModel item) async {

    final newQty = item.quantity + 1;

    /// LOCAL MODE
    if (state.isLocalMode) {

      _localCart = _localCart.map((e) {

        if (e.id == item.id) {
          return e.copyWith(quantity: newQty);
        }

        return e;

      }).toList();

      state = state.copyWith(items: [..._localCart]);

      return;
    }

    /// API MODE
    await repository.updateCart(
      item.id,
      item.productId,
      newQty,
    );

    state = state.copyWith(
      items: state.items.map((e) {
        if (e.id == item.id) {
          return e.copyWith(quantity: newQty);
        }
        return e;
      }).toList(),
    );
  }

  /// DECREASE
  Future<void> decrease(CartModel item) async {

    if (item.quantity <= 1) return;

    final newQty = item.quantity - 1;

    /// LOCAL MODE
    if (state.isLocalMode) {

      _localCart = _localCart.map((e) {

        if (e.id == item.id) {
          return e.copyWith(quantity: newQty);
        }

        return e;

      }).toList();

      state = state.copyWith(items: [..._localCart]);

      return;
    }

    /// API MODE
    await repository.updateCart(
      item.id,
      item.productId,
      newQty,
    );

    state = state.copyWith(
      items: state.items.map((e) {
        if (e.id == item.id) {
          return e.copyWith(quantity: newQty);
        }
        return e;
      }).toList(),
    );
  }

  /// REMOVE
  Future<void> remove(CartModel item) async {

    /// LOCAL MODE
    if (state.isLocalMode) {

      _localCart.removeWhere((e) => e.id == item.id);

      state = state.copyWith(items: [..._localCart]);

      return;
    }

    /// API MODE
    await repository.removeCart(item.id);

    await loadCart();
  }

  /// CLEAR CART

  Future<void> clearCart() async {

    /// LOCAL MODE — wipe the in-memory list directly
    if (state.isLocalMode) {
      _localCart = [];
      state = state.copyWith(items: []);
      return;
    }

    /// API MODE — remove every item from the server, then sync state
    final itemsToRemove = [...state.items];
    for (final item in itemsToRemove) {
      try {
        await repository.removeCart(item.id);
      } catch (e) {
        print("CLEAR CART REMOVE ERROR: $e");
      }
    }

    // Reset local state regardless of API errors
    _localCart = [];
    state = state.copyWith(items: []);
  }

  /// SHIPPING
  void setShipping(double value) {

    state = state.copyWith(shipping: value);

  }
}