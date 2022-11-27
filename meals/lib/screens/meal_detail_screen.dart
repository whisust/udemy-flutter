import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-details';

  const MealDetailScreen({Key? key}) : super(key: key);

  Widget buildSectionTitle(String text, BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10), child: Text(text, style: Theme.of(context).textTheme.titleMedium));
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: 200,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)?.settings.arguments as Meal;
    return Scaffold(
        appBar: AppBar(title: Text(meal.title)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(height: 300, width: double.infinity, child: Image.network(meal.imageUrl, fit: BoxFit.cover)),
              buildSectionTitle('Ingredients', context),
              buildContainer(ListView.builder(
                  itemCount: meal.ingredients.length,
                  itemBuilder: (ctx, index) => Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(meal.ingredients[index]),
                      )))),
              buildSectionTitle('Steps', context),
              buildContainer(ListView.builder(
                  itemCount: meal.steps.length,
                  itemBuilder: (ctx, index) => Column(
                        children: [
                          ListTile(
                              leading: CircleAvatar(child: Text('# ${index + 1}')),
                              title: Text(
                                meal.steps[index],
                                style: Theme.of(context).textTheme.bodyMedium,
                              )),
                          Divider()
                        ],
                      )))
            ],
          ),
        ));
  }
}
