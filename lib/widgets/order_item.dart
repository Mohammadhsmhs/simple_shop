import 'package:flutter/material.dart';

import '/providers/orders.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;
  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 12,
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle: Text('${order.time}'),
          )
        ],
      ),
    );
  }
}
