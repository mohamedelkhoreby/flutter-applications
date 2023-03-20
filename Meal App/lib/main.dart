import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/meal.dart';
import './screens/categories_screen.dart';
import './screens/category_meal_screen.dart';
import './screens/filterscreen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabscreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegen': false,
    'vegetarian': false,
  };

  List<Meal> availablemeal = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void setFilter(Map<String, bool> filterdate) {
    setState(() {
      filters = filterdate;
      availablemeal = DUMMY_MEALS.where((meal) {
        if (filters['gluten'] == true && meal.isGlutenFree == false) {
          return false;
        }
        if (filters['lactose'] == true && meal.isLactoseFree == false) {
          return false;
        }
        if (filters['vegen'] == true && meal.isVegan == false) {
          return false;
        }
        if (filters['vegetarian'] == true && meal.isVegetarian == false) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavorite(String mealId) {
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
    } else {
      setState(() {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool isMealFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
              // bodyText1: const TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
              // bodyText2: const TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
              titleMedium:
                  const TextStyle(fontSize: 24, fontFamily: 'RobotoCondensed')),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(secondary: Colors.amber)),
      home: const CategoriesScreen(),
      initialRoute: '//',
      routes: {
        '//': (context) => TabScreen(favoriteMeals),
        CategoriesMealScreen.routeName: (context) =>
            CategoriesMealScreen(availablemeal),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(toggleFavorite, isMealFavorite),
        FilterScreen.routeName: (context) => FilterScreen(setFilter, filters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal App"),
      ),
      body: null,
    );
  }
}
