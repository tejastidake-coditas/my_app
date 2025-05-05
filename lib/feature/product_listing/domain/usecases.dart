import 'package:dartz/dartz.dart';
import 'package:my_app/core/networking/failure_constants.dart';
import 'package:my_app/feature/product_listing/domain/entity.dart';
import 'package:my_app/feature/product_listing/domain/repository.dart';

class ProductUseCases {
  final ProductsRepository productRepository;
  ProductUseCases(this.productRepository);

  Future<Either<Failure, List<ProductListingEntity>>> getAllProducts() async {
    final response = await productRepository.getAllProducts();

    return response.fold(
      (failure) => Left(failure),
      (products) => Right(products),
    );
  }
}
