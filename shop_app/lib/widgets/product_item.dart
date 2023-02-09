import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/cart.dart';
import '../screens/product_detail_screen.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final authProvider = Provider.of<Auth>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          child: GestureDetector(
            child: Image.network(product.imageUrl, fit: BoxFit.cover),
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id);
            },
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (BuildContext ctx, product, Widget? child) {
                return IconButton(
                  icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_outline),
                  onPressed: () {
                    product.toggleFavorite(authProvider.token, authProvider.userId);
                  },
                  color: Theme.of(context).colorScheme.secondary,
                );
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Added item to cart'),
                  action: SnackBarAction(label: 'Undo', onPressed: () {
                    cart.removeSingleItem(product.id);
                  })
                ));
              },
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            subtitle: Text(product.description),
          )),
    );
  }
}
