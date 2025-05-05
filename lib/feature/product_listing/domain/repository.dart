import 'package:dartz/dartz.dart';
import 'package:my_app/core/networking/failure_constants.dart';
import 'package:my_app/feature/product_listing/domain/entity.dart';

abstract interface class ProductsRepository {
  Future<Either<Failure, List<ProductListingEntity>>> getAllProducts();
}
