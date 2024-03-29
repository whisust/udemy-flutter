import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final product =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
        // appBar: AppBar(title: Text(product.title)),
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Container(child: Text(product.title), ),
            background: Hero(
                tag: product.id,
                child: Image.network(product.imageUrl, fit: BoxFit.cover)),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          const SizedBox(height: 10),
          Text(
            '\$${product.price}',
            style: const TextStyle(color: Colors.grey, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                product.description,
                textAlign: TextAlign.center,
              )),
        ])),
      ],
    ));
  }
}
