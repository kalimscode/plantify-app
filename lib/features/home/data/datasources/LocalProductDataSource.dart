import '../../domain/entities/product_entity.dart';

class LocalProductDataSource {
  List<ProductEntity> getFallbackProducts() {
    return [
      ProductEntity(
        id: "local_1",
        name: "Variegated snake",
        price: 25,
        image: "assets/images/plant1.png",
        category: "Indoor",
      ),
      ProductEntity(
        id: "local_2",
        name: "Strelitzia Nicolai",
        price: 35,
        image: "assets/images/plant2.png",
        category: "Indoor",
      ),
      ProductEntity(
        id: "local_3",
        name: "Sansevieria Care",
        price: 60,
        image: "assets/images/plant3.png",
        category: "Outdoor",
      ),
      ProductEntity(
        id: "local_4",
        name: "Lady's Bedstraw",
        price: 40,
        image: "assets/images/plant4.png",
        category: "Indoor",
      ),
    ];
  }
}