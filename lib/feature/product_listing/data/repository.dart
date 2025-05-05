import 'package:dartz/dartz.dart';
import 'package:my_app/core/networking/failure_constants.dart';
import 'package:my_app/feature/product_listing/data/data_source.dart';
import 'package:my_app/feature/product_listing/domain/entity.dart';
import 'package:my_app/feature/product_listing/domain/repository.dart';

class ProductRepositoryImplementation implements ProductsRepository {
  final ProductListingDataSource productListingDataSource;
  ProductRepositoryImplementation(this.productListingDataSource);

  @override
  Future<Either<Failure, List<ProductListingEntity>>> getAllProducts() async {
    final response = await productListingDataSource.getAllProducts();
    return response.fold(
      (failure) => Left(failure),
      (products) => Right(products),
    );
  }
}
