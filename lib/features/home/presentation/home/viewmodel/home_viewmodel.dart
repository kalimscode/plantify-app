import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/datasources/LocalProductDataSource.dart';
import '../../../domain/repositories/product_repository.dart';
import '../../favorite_plant/data/datasources/favourite_remote_datasource.dart';
import '../../model/product_ui_model.dart';


class HomeViewModel
    extends StateNotifier<AsyncValue<List<ProductUiModel>>> {

  final ProductRepository repository;
  final FavouriteRemoteDataSource favouriteApi;
  final LocalProductDataSource local;

  final Set<String> _likedIds = {};
  List<ProductUiModel> _allProducts = [];

  HomeViewModel(
      this.repository,
      this.favouriteApi,
      this.local,
      ) : super(const AsyncLoading()) {
    loadProducts();
  }

  Future<void> loadProducts({String? category}) async {
    state = const AsyncLoading();

    final products =
    await repository.getProducts(category: category);

    _allProducts = products.map((e) {
      return ProductUiModel(
        id: e.id,
        title: e.name,
        price: e.price,
        imagePath: e.image ?? "assets/images/plant1.png",
        category: e.category ?? "General",
        isLiked: _likedIds.contains(e.id),
      );
    }).toList();

    state = AsyncData(_allProducts);
  }

  void loadProductsByCategory(String category) {
    if (category == "All") {
      state = AsyncData(_allProducts);
      return;
    }

    final filtered = _allProducts
        .where((p) =>
    p.category?.toLowerCase() ==
        category.toLowerCase())
        .toList();

    state = AsyncData(filtered);
  }

  void search(String value) {
    if (value.isEmpty) {
      state = AsyncData(_allProducts);
      return;
    }

    final filtered = _allProducts
        .where((p) =>
        p.title.toLowerCase()
            .contains(value.toLowerCase()))
        .toList();

    state = AsyncData(filtered);
  }

  void toggleLike(int index) {
    state.whenData((products) async {
      final updated = [...products];
      final product = updated[index];

      final newLiked = !product.isLiked;

      updated[index] =
          product.copyWith(isLiked: newLiked);

      state = AsyncData(updated);

      if (newLiked) {
        _likedIds.add(product.id);
        try { await favouriteApi.add(product.id); } catch (_) {}
      } else {
        _likedIds.remove(product.id);
        try { await favouriteApi.remove(product.id); } catch (_) {}
      }

      _allProducts = updated;
    });
  }
}