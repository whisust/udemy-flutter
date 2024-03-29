import 'package:flutter/material.dart';
import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget _buildListTile(String text, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(text, style: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 24, fontWeight: FontWeight.bold)),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      Container(
        height: 120,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        alignment: Alignment.centerLeft,
        color: Theme.of(context).colorScheme.secondary,
        child: Text('Cooking Up!',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30, color: Theme.of(context).primaryColor)),
      ),
      SizedBox(height: 20),
      _buildListTile('Meals', Icons.restaurant, () {
        Navigator.of(context).pushReplacementNamed('/');
      }),
      _buildListTile('Filters', Icons.settings, () {
        Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
      }),
    ]));
  }
}
