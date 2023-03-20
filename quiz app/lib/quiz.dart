import 'package:flutter/material.dart';
import 'main.dart';
import 'answer.dart';
import 'quistion.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> question;
  final int questionindex;
  final Function(int s) answerquistion;

  Quiz(this.question, this.questionindex, this.answerquistion);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Quistion(question[questionindex]['questiontext'] as String),
      ...(question[questionindex]['answers'] as List<Map<String, Object>>)
          .map((answer) {
        return Answer(
            () => answerquistion(int.parse(answer['score'].toString())),
            answer['text'].toString());
      }).toList(),
    ]);
  }
}
