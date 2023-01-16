// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegeterian = false;
  bool _vegan = false;
  bool _dairyFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _vegeterian = widget.currentFilters['vegeterian']!;
    _vegan = widget.currentFilters['vegan']!;
    _dairyFree = widget.currentFilters['dairy']!;
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description, bool value,
      Function(bool) updateValue) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(description),
        value: value,
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters'),
          actions: [
            IconButton(
                onPressed: () {
                  final selectedFilter = {
                    "gluten": _glutenFree,
                    "dairy": _dairyFree,
                    "vegan": _vegan,
                    "vegeterian": _vegeterian
                  };

                  widget.saveFilters(selectedFilter);
                },
                icon: const Icon(Icons.save))
          ],
        ),
        drawer: MainDrawer(),
        body: Column(children: [
          Container(
              padding: const EdgeInsets.all(20),
              child: Text('Adjust your meal selection',
                  style: Theme.of(context).textTheme.headline1)),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                  'Gluten-free', 'Only include gluten-free meals', _glutenFree,
                  (newValue) {
                setState(() {
                  _glutenFree = newValue;
                });
              }),
              _buildSwitchListTile(
                  'Vegetarian', 'Only include vegetarian meals', _vegeterian,
                  (newValue) {
                setState(() {
                  _vegeterian = newValue;
                });
              }),
              _buildSwitchListTile('Vegan', 'Only include vegan meals', _vegan,
                  (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              }),
              _buildSwitchListTile(
                  'Dairy-free', 'Only include dairy-free meals', _dairyFree,
                  (newValue) {
                setState(() {
                  _dairyFree = newValue;
                });
              }),
            ],
          ))
        ]));
  }
}
