import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Your cart')),
        body: Column(children: [
          Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text('Total', style: TextStyle(fontSize: 20)),
                      Spacer(),
                      Chip(
                        label: Text('\$${cart.totalAmount.toStringAsFixed(2)}',
                            style: Theme.of(context).primaryTextTheme.titleSmall),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          final orders = Provider.of<Orders>(context, listen: false);
                          orders.addOrder(cart.items.values.toList(), cart.totalAmount);
                          cart.clear();
                        },
                        child: Text('ORDER NOW'),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ))),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            itemCount: cart.itemCount,
            itemBuilder: (BuildContext context, int index) {
              final itemEntry = cart.items.entries.toList()[index];
              return CartItem(
                id: itemEntry.value.id,
                productId: itemEntry.key,
                quantity: itemEntry.value.quantity,
                title: itemEntry.value.title,
                price: itemEntry.value.pricePerProduct,
              );
            },
          ))
        ]));
  }
}
