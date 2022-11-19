import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final String categoryTitle = routeArgs['title'] as String;
    final categoryId = routeArgs['id'];
    final meals = DUMMY_MEALS.where((meal) => meal.categoryIds.contains(categoryId)).toList();
    return Scaffold(
        appBar: AppBar(title: Text(categoryTitle)),
        body: ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(meal: meals[index]);
            },
            itemCount: meals.length));
  }
}
