import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_shop/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;

  const CartItem(this.id);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final item = cart.items[id];
    //  cart.items.values.toList().firstWhere((element) => element.id == id);
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      background: Container(
        padding: const EdgeInsets.all(25),
        alignment: Alignment.centerRight,
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) => cart.deleteItem(id),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${item!.price}'),
              ),
            ),
          ),
          title: Text('${item.title}'),
          subtitle: Text("total :${item.price * item.quantity}"),
          trailing: Text('${item.quantity} x'),
        ),
      ),
    );
  }
}
