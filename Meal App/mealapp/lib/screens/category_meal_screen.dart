import 'package:flutter/material.dart';
import 'package:mealapp/dummy_data.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/widgets/meal_item.dart';

class CategoriesMealScreen extends StatefulWidget {
  static const routeName = 'category_meals';

  final List<Meal> availableMeals;

  CategoriesMealScreen(this.availableMeals, {super.key});
  @override
  CategoriesMealScreenState createState() => CategoriesMealScreenState();
}

class CategoriesMealScreenState extends State<CategoriesMealScreen> {
  late String categoryTitle;
  late List<Meal> displayedmeal;
  @override
  void didChangeDependencies() {
    final routeArg =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryId = routeArg['id'];
    categoryTitle = routeArg['title']!;
    displayedmeal = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void removeMeal(String mealid) {
    setState(() {
      displayedmeal.removeWhere((meal) => meal.id == mealid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return MealItem(
            id: displayedmeal[index].id,
            imageUrl: displayedmeal[index].imageUrl,
            title: displayedmeal[index].title,
            duration: displayedmeal[index].duration,
            affordability: displayedmeal[index].affordability,
            complexity: displayedmeal[index].complexity,
          );
        }),
        itemCount: displayedmeal.length,
      ),
    );
  }
}
