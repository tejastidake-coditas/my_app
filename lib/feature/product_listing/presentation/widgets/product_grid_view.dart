import 'package:flutter/material.dart';
import 'package:my_app/core/constants/text_constants.dart';
import 'package:my_app/feature/product_listing/domain/entity.dart';
import 'package:my_app/feature/product_listing/presentation/widgets/product_card_tile.dart';

class ProductGridView extends StatelessWidget {
  final List<ProductListingEntity> products;

  const ProductGridView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text(TextConstants.noProductsText));
    }

    return GridView.builder(
      padding: EdgeInsets.all(18.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 206,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCardTile(product: product);
      },
    );
  }
}
