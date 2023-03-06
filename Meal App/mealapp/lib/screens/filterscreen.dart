// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mealapp/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter ';

  final Function saveFilters;
  final Map<String, bool> currentfilters;

  FilterScreen(this.saveFilters, this.currentfilters);
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool glutenfree = false;
  bool lactodefree = false;
  bool vegen = false;
  bool vagentarian = false;

  @override
  void initState() {
    bool? glutenfree = widget.currentfilters['gluten'];
    bool? lactodefree = widget.currentfilters['lactose'];
    bool? vegen = widget.currentfilters['vegan'];
    bool? vagentarian = widget.currentfilters['vegetarian'];
    super.initState();
  }

  Widget buildSwithListTile(String title, String desc, bool currentvalu,
      void Function(bool) updatevalue) {
    return SwitchListTile(
      title: Text(title),
      value: currentvalu,
      subtitle: Text(desc),
      onChanged: updatevalue,
      activeColor: Theme.of(context).colorScheme.primary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your filter"),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFiltes = {
                  'gluten': glutenfree,
                  'lactose': lactodefree,
                  'vagen': vegen,
                  'vegetarian': vagentarian,
                };
                widget.saveFilters(selectedFiltes);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text("Adjust your meal selection",
              style: Theme.of(context).textTheme.titleMedium),
        ),
        Expanded(
            child: ListView(
          children: [
            buildSwithListTile(
              'gluten-free',
              'only include gulten-free meal',
              glutenfree,
              (newvalue) {
                setState(() {
                  glutenfree = newvalue;
                });
              },
            ),
            buildSwithListTile(
              'lactose-free',
              'only include lactode-free meal',
              lactodefree,
              (newvalue) {
                setState(() {
                  lactodefree = newvalue;
                });
              },
            ),
            buildSwithListTile(
              'vegen',
              'only include vagen meal',
              vegen,
              (newvalue) {
                setState(() {
                  vegen = newvalue;
                });
              },
            ),
            buildSwithListTile(
              'vegetarian',
              'only include vagentarian meal',
              vagentarian,
              (newvalue) {
                setState(() {
                  vagentarian = newvalue;
                });
              },
            ),
          ],
        ))
      ]),
      drawer: MainDrawer(),
    );
  }
}
