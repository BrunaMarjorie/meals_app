// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favMeals;

  FavouritesScreen(this.favMeals);

  @override
  Widget build(BuildContext context) {
    if (favMeals.isEmpty) {
      return const Center(
          child: Text('You have no favourite meals yet - start adding some!'));
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(meal: favMeals[index]);
        },
        itemCount: favMeals.length,
      );
    }
  }
}
