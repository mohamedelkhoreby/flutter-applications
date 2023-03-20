import 'package:flutter/material.dart';
import 'package:flutter_application_1/quiz.dart';
import 'package:flutter_application_1/result.dart';
import 'quistion.dart';
import 'answer.dart';

void main() {
  runApp(const MyApp());
}

Color B = Colors.black;
Color W = Colors.white;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'َQuiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _quistionindex = 0;
  int _totalscore = 0;

  bool isSwitced = false;
  final List<Map<String, Object>> _question = [
    {
      'questiontext': 'what\'s your favorite color?',
      'answers': [
        {'text': 'black', 'score': 10},
        {'text': 'white', 'score': 0},
        {'text': 'blue', 'score': 0},
        {'text': 'red', 'score': 0}
      ]
    },
    {
      'questiontext': 'what\'s your favorite animal?',
      'answers': [
        {'text': 'dog', 'score': 0},
        {'text': 'cat', 'score': 10},
        {'text': 'horse', 'score': 0},
        {'text': 'lion', 'score': 0}
      ]
    },
    {
      'questiontext': 'what\'s your favorite car?',
      'answers': [
        {'text': 'mercedes', 'score': 10},
        {'text': 'bmw', 'score': 0},
        {'text': 'honda', 'score': 0},
        {'text': 'toyota', 'score': 10}
      ]
    },
  ];
  void _resetquiz() {
    setState(() {
      _quistionindex = 0;
      _totalscore = 0;
    });
  }

  void answerquistion(int score) {
    _totalscore += score;

    setState(() {
      _quistionindex += 1;
    });

    print("answer chosen!");
    print(_totalscore);
    print(_quistionindex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Quiz app",
            style: TextStyle(fontSize: 20, color: B),
          ),
          actions: <Widget>[
            Switch(
              activeColor: Colors.white,
              //thumb تعنى الكورة
              inactiveThumbColor: Colors.black,
              //track تعنى المسار
              value: isSwitced,
              onChanged: (value) {
                setState(() {
                  isSwitced = value;
                  if (isSwitced == true) {
                    B = Colors.white;
                    W = Colors.black;
                  }
                  if (isSwitced == false) {
                    B = Colors.black;
                    W = Colors.white;
                  }
                });
              },
            ),
          ],
        ),
        body: Container(
            color: W,
            child: _quistionindex < _question.length
                ? Quiz(_question, _quistionindex, answerquistion)
                : Result(_resetquiz, _totalscore)));
  }
}
