import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_shop/providers/cart.dart';
import 'package:simple_shop/screens/cart_screen.dart';
import 'package:simple_shop/widgets/badge.dart';

import '../widgets/products_grid.dart';

enum menu {
  favorits,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _isFavorit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
        actions: [
          PopupMenuButton(
            onSelected: (menu val) {
              setState(() {
                if (val == menu.favorits)
                  _isFavorit = true;
                else
                  _isFavorit = false;
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("only favorits"),
                value: menu.favorits,
              ),
              PopupMenuItem(
                child: Text("all"),
                value: menu.all,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (context, cart, ch) => Badge(
              child: ch!,
              value: cart.cartCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.route);
              },
            ),
          ),
        ],
      ),
      body: ProductsGrid(_isFavorit),
    );
  }
}
