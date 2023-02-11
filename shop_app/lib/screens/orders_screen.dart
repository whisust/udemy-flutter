import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Your orders')),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: Provider.of<Orders>(context, listen: false).fetchOrders(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          'Something bad happened (${snapshot.error?.toString()})'));
                } else {
                  return Consumer<Orders>(
                      builder: (ctx, ordersProvider, _) => ListView.builder(
                          itemCount: ordersProvider.orders.length,
                          itemBuilder: (ctx, i) =>
                              OrderItem(ordersProvider.orders[i])));
                }
              }
            }));
  }
}
