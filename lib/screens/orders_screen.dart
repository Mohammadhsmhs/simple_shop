import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_shop/widgets/app_drwaer.dart';

import '/widgets/order_item.dart';

import '/providers/orders.dart' show Orders;

class OrdersScreen extends StatelessWidget {
  static final route = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) => OrderItem(orderData.orders[index]),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
