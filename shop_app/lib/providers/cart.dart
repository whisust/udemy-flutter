import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double pricePerProduct;

  CartItem({required this.id, required this.title, required this.quantity, required this.pricePerProduct});

}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (cartItem) => CartItem(
              id: cartItem.id,
              title: cartItem.title,
              pricePerProduct: cartItem.pricePerProduct,
              quantity: cartItem.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId, () => CartItem(id: DateTime.now().toString(), title: title, pricePerProduct: price, quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    final cartItem = _items[productId];
    if(cartItem != null){
      if (cartItem.quantity > 1) {
        _items.update(
            productId,
                (cartItem) => CartItem(
                id: cartItem.id,
                title: cartItem.title,
                pricePerProduct: cartItem.pricePerProduct,
                quantity: cartItem.quantity - 1));
      } else {
        _items.remove(productId);
      }
      notifyListeners();
    }
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.quantity * value.pricePerProduct;
    });
    return total;
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
