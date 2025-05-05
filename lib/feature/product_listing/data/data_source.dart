import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_app/core/constants/text_constants.dart';
import 'package:my_app/core/networking/failure_constants.dart';
import 'package:my_app/core/networking/network_constants.dart';
import 'package:my_app/core/networking/network_service.dart';
import 'package:my_app/core/utils/enums/method_enum.dart';
import 'package:my_app/feature/product_listing/data/model.dart';

abstract interface class ProductListingDataSource {
  Future<Either<Failure, List<ProductListingModel>>> getAllProducts();
}

class ProductListingDataSourceImplementation
    implements ProductListingDataSource {
  final NetworkService networkService;
  ProductListingDataSourceImplementation(this.networkService);

  @override
  Future<Either<Failure, List<ProductListingModel>>> getAllProducts() async {
    try {
      final result = await networkService.request(
        NetworkConstants.productEndPoint,
        method: Method.get,
      );
      return result.fold((failure) => Left(failure), (response) {
        if (response.data is Map<String, dynamic>) {
          final List data = response.data['products'] ?? [];
          final products =
              data
                  .map((products) => ProductListingModel.fromJson(products))
                  .toList();
          return Right(products);
        } else {
          return Left(
            ServiceFailure(message: TextConstants.invalidResponseFormat),
          );
        }
      });
    } on DioException catch (error) {
      return Left(ServiceFailure(message: '${error.message}'));
    } catch (error) {
      return Left(UnexpectedFailure());
      // we can also handle error here
    }
  }
}
