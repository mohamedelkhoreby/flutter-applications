import 'package:flutter/material.dart';
import 'package:mealapp/screens/filterscreen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
        leading: Icon(icon, size: 26),
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 24,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold),
        ),
        onTap: tapHandler());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.primary,
            child: const Text("Cooking up!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
              leading: const Icon(Icons.restaurant, size: 26),
              title: const Text(
                "Meal",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold),
              ),
              onTap: (() => Navigator.of(context).pushReplacementNamed('//'))),
          ListTile(
              leading: const Icon(Icons.settings, size: 26),
              title: const Text(
                "Filters",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold),
              ),
              onTap: (() => Navigator.of(context)
                  .pushReplacementNamed(FilterScreen.routeName))),
        ],
      ),
    );
  }
}
