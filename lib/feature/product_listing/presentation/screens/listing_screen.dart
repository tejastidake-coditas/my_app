import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/constants/text_constants.dart';
import 'package:my_app/core/di/injector.dart';
import 'package:my_app/feature/product_listing/presentation/bloc/product_listing_bloc.dart';
import 'package:my_app/feature/product_listing/presentation/bloc/product_listing_event.dart';
import 'package:my_app/feature/product_listing/presentation/bloc/product_listing_state.dart';
import 'package:my_app/feature/product_listing/presentation/widgets/product_grid_view.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductListingBloc>(
      create:
          (_) =>
              Injector.injectorInstance<ProductListingBloc>()
                ..add(GetAllProductsEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text(TextConstants.appName)),
        body: BlocBuilder<ProductListingBloc, ProductListingState>(
          builder: (context, state) {
            if (state is ProductListingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductListingLoaded) {
              if (state.products.isEmpty) {
                return const Center(child: Text(TextConstants.noProductsText));
              }
              return ProductGridView(products: state.products);
            } else if (state is ProductListingError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
