import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import '../providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Products'), actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add))
      ]),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (BuildContext ctx, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () => _refreshProducts(context),
                  child: Consumer<Products>(
                    builder: (ctx, productsProvider, _) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView.builder(
                            itemCount: productsProvider.items.length,
                            itemBuilder: (ctx, index) {
                              final product = productsProvider.items[index];
                              return Column(
                                children: [
                                  UserProductItem(
                                    title: product.title,
                                    imageUrl: product.imageUrl,
                                    id: product.id,
                                  ),
                                  Divider()
                                ],
                              );
                            })),
                  ),
                );
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
