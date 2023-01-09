import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  const FiltersScreen({Key? key, required this.currentFilters, required this.saveFilters}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    super.initState();
    _glutenFree = widget.currentFilters['gluten']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegan = widget.currentFilters['vegan']!;
  }

  Widget _buildSwitchListTile(String title, String description, bool value, ValueChanged<bool> updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: updateValue,
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your filters'), actions: [
        IconButton(
            onPressed: () {
              widget.saveFilters({
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              });
            },
            icon: Icon(Icons.save))
      ]),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.all(20),
              child: Text('Adjust your meal selection', style: Theme.of(context).textTheme.titleMedium)),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile('Gluten Free', 'Only include gluten-free meals.', _glutenFree, (newValue) {
                setState(() {
                  _glutenFree = newValue;
                });
              }),
              _buildSwitchListTile('Lactose Free', 'Only include lactose-free meals.', _lactoseFree, (newValue) {
                setState(() {
                  _lactoseFree = newValue;
                });
              }),
              _buildSwitchListTile('Vegetarian', 'Only include veggie meals.', _vegetarian, (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              }),
              _buildSwitchListTile('Vegan', 'Only include vegan meals.', _vegan, (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              }),
            ],
          )),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
