import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_shop/providers/products.dart';
import 'package:simple_shop/screens/edit_product_screen.dart';
import 'package:simple_shop/widgets/user_product_item.dart';

import '/widgets/app_drwaer.dart';

class UserProductScreen extends StatelessWidget {
  static const route = '/user-screen';
  @override
  Widget build(BuildContext context) {
    var productsItem = Provider.of<Products>(context).items;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Manage products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.route);
            },
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (context, index) => UserProductItem(
            productsItem[index].id,
            productsItem[index].title,
            productsItem[index].imageUrl,
          ),
          itemCount: productsItem.length,
        ),
      ),
    );
  }
}
