import 'package:my_app/core/constants/style_constants.dart';
import 'package:my_app/core/constants/color_constants.dart';
import 'package:my_app/feature/product_listing/domain/entity.dart';
import 'package:flutter/material.dart';

class ProductCardTile extends StatelessWidget {
  final ProductListingEntity product;

  const ProductCardTile({super.key, required this.product});

  void _handleTap(BuildContext context, int productId) {
    // if we want to show details in future, we can navigate to details page & show details there using productId passed from here
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => _handleTap(context, product.id),
    child: Card(
      elevation: 2,
      color: ColorConstants.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Center(
                child: SizedBox(
                  height: 120,
                  child: Image.network(
                    product.thumbnail,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => const Center(
                          child: Icon(Icons.broken_image, size: 48),
                        ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.title.toUpperCase(),
              style: StyleConstants.productCardTileTitle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.category,
                  style: StyleConstants.productCardTileCategory,
                ),
                Text(
                  '\$ ${product.price}',
                  style: StyleConstants.productCardTilePrice,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
