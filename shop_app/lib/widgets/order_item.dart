import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  const OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: _expanded ? min(widget.order.products.length * 20 + 115, 280) : 110,
      curve: Curves.easeIn,
      child: Card(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                  title: Text('\$${widget.order.amount}'),
                  subtitle: Text(DateFormat('dd/MM/yyy').format(widget.order.dateTime)),
                  trailing: IconButton(
                    icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                  )),
                AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    height: _expanded ? min(widget.order.products.length * 20 + 10, 100) : 0,
                    child: ListView(
                        children: widget.order.products.map(((product) {
                      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(product.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('${product.quantity} x \$${product.pricePerProduct}',
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                      ]);
                    })).toList()))
            ],
          )),
    );
  }
}
