import 'package:equatable/equatable.dart';

class ProductListingEntity extends Equatable {
  final int id;
  final String title;
  final String thumbnail;
  final String category;
  final double price;

  const ProductListingEntity({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.category,
    required this.price,
  });

  @override
  List<Object?> get props => <Object?>[id, title, thumbnail, category, price];
}
