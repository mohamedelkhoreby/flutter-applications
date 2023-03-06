import 'package:flutter/material.dart';
import 'main.dart';

class Result extends StatelessWidget {
  final VoidCallback Q;
  final int resultscore;
  Result(this.Q, this.resultscore);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      Text("the score=  $resultscore",
          style: TextStyle(fontSize: 30, color: B)),
      TextButton(
        child: const Text("retart the app", style: TextStyle(fontSize: 30)),
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        onPressed: Q,
      )
    ]));
  }
}
