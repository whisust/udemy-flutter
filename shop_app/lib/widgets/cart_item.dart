import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const CartItem(
      {required this.id, required this.price, required this.quantity, required this.title, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(context: context, builder: (ctx) {
          return AlertDialog(title: Text('Are you sure?'),
              content: Text('Do you want to remove the item from the cart?'),
          actions:[
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text('No, keep it'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text('Yes, Remove'),
            )
          ]);
        });
      },
      background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(Icons.delete, color: Colors.white, size: 40),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4)),
      onDismissed: (direction) {
        final cart = Provider.of<Cart>(context, listen: false);
        cart.removeItem(productId);
      },
      child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
              padding: EdgeInsets.all(8),
              child: ListTile(
                leading:
                    CircleAvatar(child: Padding(padding: EdgeInsets.all(3), child: FittedBox(child: Text('\$$price')))),
                title: Text(title),
                subtitle: Text('Total: \$${price * quantity}'),
                trailing: Text('$quantity x'),
              ))),
    );
  }
}
