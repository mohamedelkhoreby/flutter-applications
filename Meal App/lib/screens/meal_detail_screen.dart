import 'package:flutter/material.dart';
import 'package:mealapp/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'meals_detail';
  final Function toggleFavorites;
  final Function isFavorite;
  MealDetailScreen(this.toggleFavorites, this.isFavorite);
  Widget buildcontianr(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealid = ModalRoute.of(context)!.settings.arguments as String;
    final selectedmeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealid);

    return Scaffold(
      appBar: AppBar(title: Text(selectedmeal.title)),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(selectedmeal.imageUrl, fit: BoxFit.cover),
          ),
          buildsectionTitle(context, "Ingredients"),
          buildcontianr(
            ListView.builder(
              itemBuilder: ((context, index) => Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(selectedmeal.ingredients[index]),
                    ),
                  )),
              itemCount: selectedmeal.ingredients.length,
            ),
          ),
          buildsectionTitle(context, "steps"),
          buildcontianr(
            ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(child: Text("#${index + 1} ")),
                    title: Text(selectedmeal.steps[index]),
                  ),
                  const Divider(),
                ],
              ),
              itemCount: selectedmeal.steps.length,
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorites(mealid),
        child: Icon(
          isFavorite(mealid) ? Icons.star : Icons.star_border,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildsectionTitle(BuildContext context, String? text) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Text(text!, style: Theme.of(context).textTheme.titleMedium));
  }
}
