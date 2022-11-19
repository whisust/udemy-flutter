import 'package:flutter/material.dart';
import './category_meals_screen.dart';
import './categories_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.pink,
            colorScheme: ColorScheme.light(primary: Colors.pink, secondary: Colors.amber),
            canvasColor: const Color.fromRGBO(255, 254, 229, 1),
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                bodyLarge: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                bodyMedium: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                titleSmall: TextStyle(fontSize: 18, fontFamily: 'RobotoCondensed', fontWeight: FontWeight.bold),
                titleMedium: TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed', fontWeight: FontWeight.bold),
                titleLarge: TextStyle(fontSize: 24, fontFamily: 'RobotoCondensed', fontWeight: FontWeight.bold))),
        home: const CategoriesScreen(),
        routes: {'/category-meals': (ctx) => CategoryMealsScreen()});
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text('Navigation Time!'),
      ),
    );
  }
}
