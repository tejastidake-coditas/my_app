import 'package:my_app/feature/product_listing/domain/entity.dart';

class ProductListingModel extends ProductListingEntity {
  const ProductListingModel({
    required super.id,
    required super.title,
    required super.thumbnail,
    required super.category,
    required super.price,
  });

  factory ProductListingModel.fromJson(Map<String, dynamic> json) =>
      ProductListingModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        thumbnail: json['thumbnail'] ?? '',
        category: json['category'] ?? '',
        price: json['price'] ?? 0.0,
      );
}
