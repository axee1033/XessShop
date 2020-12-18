import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int qunitity;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.qunitity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItme) {
      total += cartItme.price * cartItme.qunitity;
    });
    return total;
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  void addItems({
    String productId,
    double price,
    String title,
  }) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (oldCart) => CartItem(
              id: oldCart.id,
              price: oldCart.price,
              title: oldCart.title,
              qunitity: oldCart.qunitity + 1));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          qunitity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].qunitity > 1) {
      _items.update(
        productId,
        (oldCart) => CartItem(
            id: oldCart.id,
            price: oldCart.price,
            title: oldCart.title,
            qunitity: oldCart.qunitity - 1),
      );
    }
    if (_items[productId].qunitity ==1) {
      _items.remove(productId);  
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
