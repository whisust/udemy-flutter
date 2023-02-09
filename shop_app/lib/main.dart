import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';
import 'providers/cart.dart';
import 'providers/orders.dart';
import 'providers/products.dart';
import 'screens/user_products_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/products_overview_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/cart_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products(null, []),
          update: (BuildContext context, auth, Products? previous) {
            return Products(auth, previous == null ? [] : previous.items);
          },),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(null, []),
          update: (BuildContext context, auth, Orders? previous) {
            return Orders(auth.token, previous == null ? [] : previous.orders);
          },),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authProvider, _) {
          return MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
                primarySwatch: Colors.purple,
                colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple, accentColor: Colors.deepOrange),
                fontFamily: 'Lato',
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: Colors.purple,
                    ))),
            home: authProvider.isAuthenticated ? ProductsOverviewScreen() : AuthScreen(),
            routes: {
              AuthScreen.routeName: (ctx) => AuthScreen(),
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen()
            },
          );
        },
      ),
    );
  }
}
