import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import 'categories_screen.dart';
import 'fevoritescreen.dart';
import 'filterscreen.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  TabScreen(this.favoriteMeals);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, Object>> pages;
  @override
  void initState() {
    pages = [
      {'page': const CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoritesScreen(widget.favoriteMeals), 'title': 'Your Favorites'}
    ];
    super.initState();
  }

  int selectedPageIndex = 0;
  void selectedpage(int value) {
    setState(() {
      selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text(pages[selectedPageIndex]['title'] as String)),
        body: pages[selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
            onTap: selectedpage,
            backgroundColor: Theme.of(context).colorScheme.primary,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            unselectedItemColor: Colors.white,
            currentIndex: selectedPageIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.star), label: 'favorites'),
            ]),
        drawer: MainDrawer());
  }
}
