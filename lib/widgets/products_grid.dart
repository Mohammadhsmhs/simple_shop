import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_shop/providers/products.dart';

import '/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool _isFav;

  ProductsGrid(this._isFav);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = _isFav ? productsData.favorits : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            ),
      ),
    );
  }
}
