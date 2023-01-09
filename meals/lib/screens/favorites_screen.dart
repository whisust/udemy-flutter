import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favoriteMeals;
  const FavoritesScreen(this._favoriteMeals) : super();

  @override
  Widget build(BuildContext context) {
    if (_favoriteMeals.isEmpty) {
      return const Center(
        child: Text('You have no favorites yet, start by adding some'),
      );
    } else {
      return ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(meal: _favoriteMeals[index]);
          },
          itemCount: _favoriteMeals.length);
    }
  }
}
