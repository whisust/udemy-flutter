import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import '../providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Products'), actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add))
      ]),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: productsProvider.items.length,
              itemBuilder: (ctx, index) {
                final product = productsProvider.items[index];
                return Column(
                  children: [
                    UserProductItem(title: product.title, imageUrl: product.imageUrl, id: product.id,),
                    Divider()
                  ],
                );
              })),
      drawer: AppDrawer(),
    );
  }
}
