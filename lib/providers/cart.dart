import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get cartCount {
    return _items.length;
  }

  double get cartTotal {
    var tot = 0.0;
    _items.forEach((key, value) {
      tot += value.price * value.quantity;
    });
    return tot;
  }

  void addToCart(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (value) => CartItem(
                id: id,
                title: title,
                price: price,
                quantity: value.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          id,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void deleteItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}
