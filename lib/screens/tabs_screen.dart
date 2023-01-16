// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import './fav_screens.dart';
import './category_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favMeals;

  TabsScreen(this.favMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavouritesScreen(widget.favMeals), 'title': 'Favourites'}
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TABS AT THE TOP OF THE SCREEN
    // return DefaultTabController(
    //     length: 2,
    //     child: Scaffold(
    //       appBar: AppBar(
    //         title: const Text('Meals'),
    //         bottom: const TabBar(
    //           tabs: [
    //             Tab(
    //               icon: Icon(Icons.category),
    //               text: 'Categories',
    //             ),
    //             Tab(
    //               icon: Icon(Icons.star),
    //               text: 'Favourites',
    //             )
    //           ],
    //         ),
    //       ),
    //       body: TabBarView(
    //         children: [CategoriesScreen(), FavouritesScreen()],
    //       ),
    //     ));
    return Scaffold(
      appBar:
          AppBar(title: Text(_pages[_selectedPageIndex]['title'].toString())),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourites")
        ],
      ),
    );
  }
}
