import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/orders.dart';

import '/providers/cart.dart';
import '/providers/products.dart';
import '/screens/product_detail_screen.dart';
import '/screens/products_overview_screen.dart';
import '/screens/cart_screen.dart';
import 'screens/edit_product_screen.dart';
import '/screens/orders_screen.dart';
import '/screens/user_products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.route: (ctx) => ProductDetailScreen(),
          CartScreen.route: (ctx) => CartScreen(),
          OrdersScreen.route: (ctx) => OrdersScreen(),
          UserProductScreen.route: (ctx) => UserProductScreen(),
          EditProductScreen.route: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("simpe shop"),
      ),
      body: Center(
        child: Text("and this is the damn body"),
      ),
    );
  }
}
