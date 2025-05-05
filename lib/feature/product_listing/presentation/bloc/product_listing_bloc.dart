import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/constants/text_constants.dart';
import 'package:my_app/feature/product_listing/domain/usecases.dart';
import 'package:my_app/feature/product_listing/presentation/bloc/product_listing_event.dart';
import 'package:my_app/feature/product_listing/presentation/bloc/product_listing_state.dart';

class ProductListingBloc
    extends Bloc<ProductListingEvent, ProductListingState> {
  final ProductUseCases productUseCases;

  ProductListingBloc(this.productUseCases) : super(ProductListingInitial()) {
    on<GetAllProductsEvent>(_onGetAllProducts);
  }

  void _onGetAllProducts(
    GetAllProductsEvent event,
    Emitter<ProductListingState> emit,
  ) async {
    emit(ProductListingLoading());
    final result = await productUseCases.getAllProducts();

    result.fold(
      (failure) {
        emit(
          ProductListingError(
            '${TextConstants.errorFetchingProducts} ${failure.toString()}',
          ),
        );
      },
      (products) {
        final reversedProducts = products.reversed.toList();
        emit(ProductListingLoaded(reversedProducts));
      },
    );
  }
}
