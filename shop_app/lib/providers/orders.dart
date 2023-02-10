import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../configuration.dart';
import 'auth.dart';
import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  const OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final Auth? authProvider;

  Orders(this.authProvider, this._orders);

  List<OrderItem> get orders => [..._orders];

  Future<void> addOrder(List<CartItem> cartItems, double total) async {
    final dt = DateTime.now();
    final response = await http.post(
        Config.getFirebaseUrlFor(
            table: 'orders/${authProvider!.userId}',
            authToken: authProvider!.token),
        body: json.encode({
          'amount': total,
          'dateTime': dt.toIso8601String(),
          'products': cartItems.map((item) {
            return {
              'id': item.id,
              'title': item.title,
              'quantity': item.quantity,
              'pricePerProduct': item.pricePerProduct
            };
          }).toList()
        }));
    _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          dateTime: dt,
          products: cartItems,
        ));
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    final response = await http.get(Config.getFirebaseUrlFor(
        table: 'orders/${authProvider!.userId}',
        authToken: authProvider!.token));
    final jsonResp = json.decode(response.body);
    if (jsonResp != null) {
      _orders = (jsonResp as Map<String, dynamic>)
          .entries
          .map((entry) {
            return OrderItem(
                id: entry.key,
                amount: entry.value['amount'],
                dateTime: DateTime.parse(entry.value['dateTime']),
                products: (entry.value['products'] as List<dynamic>)
                    .map((productResp) => CartItem(
                        id: productResp['id'],
                        title: productResp['title'],
                        pricePerProduct: productResp['pricePerProduct'],
                        quantity: productResp['quantity']))
                    .toList());
          })
          .toList()
          .reversed
          .toList();
      notifyListeners();
    }
  }
}
