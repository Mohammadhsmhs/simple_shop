import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:simple_shop/providers/cart.dart' show Cart;
import 'package:simple_shop/providers/orders.dart';
import 'package:simple_shop/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const route = "/cart";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Cart",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.cartTotal}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline1!
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cart.items.values.toList(), cart.cartTotal);
                        cart.clear();
                      },
                      child: Text("purchase"))
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) =>
                CartItem(cart.items.keys.toList()[index]),
            itemCount: cart.cartCount,
          )),
        ],
      ),
    );
  }
}
