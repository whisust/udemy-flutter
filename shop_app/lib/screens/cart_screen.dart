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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: TextStyle(fontSize: 20)),
                      Spacer(),
                      Chip(
                        label: Text('\$${cart.totalAmount.toStringAsFixed(2)}',
                            style: Theme.of(context).primaryTextTheme.titleSmall),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 10),
                      OrderButton(cart: cart)
                    ],
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isButtonDisabled = widget.cart.totalAmount <= 0 || _isLoading;
    return _isLoading ?
    CircularProgressIndicator() :
    TextButton(
      onPressed: isButtonDisabled ? null : () async {
        final orders = Provider.of<Orders>(context, listen: false);
        setState(() {
          _isLoading = true;
        });
        await orders.addOrder(widget.cart.items.values.toList(), widget.cart.totalAmount);
        setState(() {
          _isLoading = false;
        });
        widget.cart.clear();
      },
      child: Text('ORDER NOW'),
    );
  }
}
