import 'package:flutter/material.dart';
import 'main.dart';

class Quistion extends StatelessWidget {
  final String quistiontext;
  Quistion(this.quistiontext);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10.0),
      child: Text(quistiontext,
          style: TextStyle(fontSize: 35, color: B),
          textAlign: TextAlign.center),
    );
  }
}
