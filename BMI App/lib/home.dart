import 'dart:math';
import 'package:bmi/result.dart';
import 'package:flutter/material.dart';
import 'result.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isMale = true;
  double heightval = 170;
  int weight = 55;
  int age = 18;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Body mass Index"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(children: [
                    M1Expanded(context, 'Male'),
                    const SizedBox(width: 15),
                    M1Expanded(context, 'Female')
                  ]))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey),
                      child: Column(
                        children: [
                          Text("Height",
                              style: Theme.of(context).textTheme.headline2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(heightval.toStringAsFixed(1),
                                  style: Theme.of(context).textTheme.headline2),
                              Text("cm",
                                  style: Theme.of(context).textTheme.bodyText1)
                            ],
                          ),
                          Slider(
                            min: 90,
                            max: 220,
                            value: heightval,
                            onChanged: (onValue) =>
                                setState(() => heightval = onValue),
                          )
                        ],
                      )))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(children: [
                    M2Expanded(context, 'weight'),
                    const SizedBox(width: 15),
                    M2Expanded(context, 'age')
                  ]))),
          Container(
              color: Colors.teal,
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 16,
              child: TextButton(
                  onPressed: (() {
                    var result = weight / pow(heightval / 100, 2);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Reuslt(
                                age: age, isMale: isMale, result: result)));
                  }),
                  child: Text('Calculate',
                      style: Theme.of(context).textTheme.headline2))),
        ]),
      ),
    );
  }

  Expanded M1Expanded(BuildContext context, String type) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isMale = (type == 'Male') ? true : false;
          });
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:
                    (isMale && type == 'Male') || (!isMale && type == 'Female')
                        ? Colors.teal
                        : Colors.blueGrey),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                type == 'Male' ? Icons.male : Icons.female,
                size: 90,
              ),
              const SizedBox(height: 15),
              Text(type == 'Male' ? 'Male' : 'Female',
                  style: Theme.of(context).textTheme.headline1)
            ])),
      ),
    );
  }

  Expanded M2Expanded(BuildContext context, String type) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.blueGrey),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(type == 'age' ? 'Age' : 'Weight',
              style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 15),
          Text(type == 'age' ? '$age' : '$weight',
              style: Theme.of(context).textTheme.headline1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    type == 'age' ? age++ : weight++;
                  });
                },
                heroTag: type == 'age' ? 'age++' : 'Weight++',
                mini: true,
                child: const Icon(Icons.add),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    type == 'age' ? age-- : weight--;
                  });
                },
                heroTag: type == 'age' ? 'age--' : 'Weight--',
                mini: true,
                child: const Icon(Icons.remove),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
//flutter.targetSdkVersion