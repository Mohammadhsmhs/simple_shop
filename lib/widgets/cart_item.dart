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
      // direction: DismissDirection.endToStart,
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
      onDismissed: (direction) => // direction == DismissDirection.endToStart
          cart.deleteItem(id),
      // : cart.deleteQuantity(id),

      confirmDismiss: (direction) {
        // if (direction == DismissDirection.startToEnd) {
        //   cart.deleteQuantity(id);
        //   return Future.value(false);
        //
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content:
                Text('confirm if u want to delete this item from your carts'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        );
      },
      // : cart.deleteQuantity(id),

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
          subtitle:
              Text("total :${(item.price * item.quantity).toStringAsFixed(2)}"),
          trailing: Text('${item.quantity} x'),
        ),
      ),
    );
  }
}
