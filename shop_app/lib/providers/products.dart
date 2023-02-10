import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../configuration.dart';
import '../providers/auth.dart';
import 'product.dart';

class Products with ChangeNotifier {
  Auth? authProvider;

  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  Products(this.authProvider, this._items);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Future<void> addProduct(Product value) async {
    var product = value;
    final response = await http.post(
        Config.getFirebaseUrlFor(
            table: 'products', authToken: authProvider?.token),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price.toStringAsFixed(2),
          'creatorId': authProvider?.userId,
        }));

    final jsonResp = json.decode(response.body);
    product = value.copyWith(id: jsonResp['name'].toString());
    _items.add(product);
    notifyListeners();
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    final response = filterByUser
        ? await http.get(Config.getFirebaseUrlFor(
            table: 'products',
            authToken: authProvider?.token,
            orderBy: 'creatorId',
            equalTo: authProvider?.userId))
        : await http.get(Config.getFirebaseUrlFor(
            table: 'products', authToken: authProvider?.token));

    final jsonResp = json.decode(response.body) as Map<String, dynamic>;
    final favResponse = await http.get(Config.getFirebaseUrlFor(
        table: 'userFavorites/${authProvider?.userId}',
        authToken: authProvider?.token));
    var favJsonResp = json.decode(favResponse.body);
    if (favJsonResp == null) {
      favJsonResp = <String, dynamic>{};
    } else {
      favJsonResp = favJsonResp as Map<String, dynamic>;
    }

    // here remove the concatenation if you have enough items
    _items = jsonResp.entries.map((entry) {
      return Product(
          id: entry.key,
          description: entry.value['description'],
          imageUrl: entry.value['imageUrl'],
          price: double.parse(entry.value['price']),
          isFavorite: favJsonResp.containsKey(entry.key)
              ? favJsonResp[entry.key]!
              : false,
          title: entry.value['title']);
    }).toList();
    notifyListeners();
  }

  Product findById(String productId) {
    return _items.firstWhere((product) => product.id == productId);
  }

  Future<void> updateProduct(String productId, Product product) async {
    final productIndex = _items.indexWhere((prod) => prod.id == productId);
    if (productIndex >= 0) {
      await http.patch(
          Config.getFirebaseUrlFor(
              table: 'products', id: productId, authToken: authProvider?.token),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price.toStringAsFixed(2),
          }));
      _items[productIndex] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String productId) {
    // Optimistic update by storing / re-adding the product if the deletion fails
    final existingProductIndex =
        _items.indexWhere((prod) => prod.id == productId);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    return http
        .delete(Config.getFirebaseUrlFor(
            table: 'products', id: productId, authToken: authProvider?.token))
        .then((response) {
      if (response.statusCode >= 400) {
        _items.insert(existingProductIndex, existingProduct!);
        notifyListeners();
        throw Exception('failed to delete my dude');
      } else {
        existingProduct = null;
      }
    });
  }
}
