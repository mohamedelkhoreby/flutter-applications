import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class Answer extends StatelessWidget {
  final String answerquistion;
  final VoidCallback X;
  Answer(this.X, this.answerquistion);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: ElevatedButton(
              child: Text(answerquistion, style: TextStyle(fontSize: 35)),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: X,
            )));
  }
}
