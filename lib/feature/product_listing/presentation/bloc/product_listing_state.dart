import 'package:equatable/equatable.dart';
import 'package:my_app/feature/product_listing/domain/entity.dart';

sealed class ProductListingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductListingInitial extends ProductListingState {}

class ProductListingLoading extends ProductListingState {}

class ProductListingLoaded extends ProductListingState {
  final List<ProductListingEntity> products;

  ProductListingLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductListingError extends ProductListingState {
  final String message;

  ProductListingError(this.message);

  @override
  List<Object?> get props => [message];
}
