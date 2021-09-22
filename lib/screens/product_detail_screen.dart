import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const route = "/product-detail";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '\$${loadedProduct.price}',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${loadedProduct.description}',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
