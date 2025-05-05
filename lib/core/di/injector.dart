import 'package:get_it/get_it.dart';
import 'package:my_app/core/networking/network_service.dart';
import 'package:my_app/feature/product_listing/data/data_source.dart';
import 'package:my_app/feature/product_listing/data/repository.dart';
import 'package:my_app/feature/product_listing/domain/repository.dart';
import 'package:my_app/feature/product_listing/domain/usecases.dart';
import 'package:my_app/feature/product_listing/presentation/bloc/product_listing_bloc.dart';

class Injector {
  static final injectorInstance = GetIt.instance;

  static void init() {
    injectorInstance.registerLazySingleton<NetworkService>(
      () => NetworkService(),
    );

    injectorInstance.registerLazySingleton<ProductListingDataSource>(
      () => ProductListingDataSourceImplementation(
        injectorInstance<NetworkService>(),
      ),
    );

    injectorInstance.registerLazySingleton<ProductsRepository>(
      () => ProductRepositoryImplementation(
        injectorInstance<ProductListingDataSource>(),
      ),
    );

    injectorInstance.registerLazySingleton<ProductUseCases>(
      () => ProductUseCases(injectorInstance<ProductsRepository>()),
    );

    injectorInstance.registerFactory<ProductListingBloc>(
      () => ProductListingBloc(injectorInstance<ProductUseCases>()),
    );
  }
}
