import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Your orders')),
        drawer: AppDrawer(),
        body: ListView.builder(
            itemCount: ordersProvider.orders.length, itemBuilder: (ctx, i) => OrderItem(ordersProvider.orders[i])));
  }
}
