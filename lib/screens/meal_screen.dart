// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealScreen extends StatelessWidget {
  static const routeName = 'MealScreen';

  final Function toggleFavourite;
  final Function isFavourite;
  final ScrollController ingredientsController = ScrollController();
  final ScrollController stepsController = ScrollController();

  MealScreen(this.toggleFavourite, this.isFavourite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 200,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(title: Text(selectedMeal.title)),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => toggleFavourite(mealId),
        child: Icon(
          isFavourite(mealId) ? Icons.favorite : Icons.favorite_outline,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(Scrollbar(
              controller: ingredientsController,
              thumbVisibility: true,
              child: ListView.builder(
                controller: ingredientsController,
                itemBuilder: ((context, index) => Card(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(selectedMeal.ingredients[index])),
                    )),
                itemCount: selectedMeal.ingredients.length,
              ),
            )),
            buildSectionTitle(context, 'Steps'),
            buildContainer(Scrollbar(
              controller: stepsController,
              thumbVisibility: true,
              child: ListView.builder(
                controller: stepsController,
                itemBuilder: ((context, index) => Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(child: Text('# ${index + 1}')),
                          title: Text(selectedMeal.steps[index]),
                        ),
                        const Divider()
                      ],
                    )),
                itemCount: selectedMeal.steps.length,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
