// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/category_screen.dart';
import './screens/meal_screen.dart';
import './screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filter = {
    "gluten": false,
    "dairy": false,
    "vegan": false,
    "vegeterian": false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filter = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filter["gluten"]! && !meal.isGlutenFree) {
          return false;
        }
        if (_filter["dairy"]! && !meal.isLactoseFree) {
          return false;
        }
        if (_filter["vegan"]! && !meal.isVegan) {
          return false;
        }
        if (_filter["vegeterian"]! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existingIndex = _favMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFav(String id) {
    return _favMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Deli Meals',
        theme: ThemeData(
            fontFamily: "Raleway",
            textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1:
                    const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                bodyText2:
                    const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                headline1: const TextStyle(
                    fontSize: 20,
                    fontFamily: "RobotoCondensed",
                    fontWeight: FontWeight.bold)),
            canvasColor: const Color.fromRGBO(255, 254, 229, 1),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
                .copyWith(secondary: Colors.amber)),
        initialRoute: '/',
        routes: {
          '/': (context) => TabsScreen(_favMeals),
          CategoryMealsScreen.routeName: (context) =>
              CategoryMealsScreen(_availableMeals),
          MealScreen.routeName: (context) =>
              MealScreen(_toggleFavourite, _isMealFav),
          FiltersScreen.routeName: (context) =>
              FiltersScreen(_filter, _setFilters)
        },
        // onGenerateRoute: (settings) =>
        //     MaterialPageRoute(builder: ((context) => CategoriesScreen())),
        onUnknownRoute: (settings) =>
            MaterialPageRoute(builder: ((context) => CategoriesScreen())));
  }
}
