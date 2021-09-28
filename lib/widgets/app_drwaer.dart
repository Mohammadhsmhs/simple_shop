import 'package:flutter/material.dart';
import 'package:simple_shop/screens/orders_screen.dart';
import 'package:simple_shop/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBar(
            title: Text('hi there'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Shop"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text("Orders"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrdersScreen.route);
            },
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text("Manage Products"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.route);
            },
          ),
        ],
      ),
    );
  }
}
