import 'package:flutter/material.dart';

import 'quiz.dart';
import 'result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _totalScore = 0;
  final _questions = const [
    {
      'question': 'Fav animal?',
      'answers': [
        {'text': 'Gustave', 'score': 5},
        {'text': 'Gustave again', 'score': 10},
        {'text': 'Perhaps Gustave', 'score': 2}
      ],
    },
    {
      'question': 'Fav color?',
      'answers': [
        {'text': 'Blue', 'score': 10},
        {'text': 'Red', 'score': 15},
        {'text': 'Green', 'score': 8},
      ],
    }
  ];

  void answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  void _resetQuiz() {
    setState(() {
      _totalScore = 0;
      _questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final body = _questionIndex < _questions.length
        ? Quiz(
            questions: _questions,
            questionIndex: _questionIndex,
            answerQuestion: answerQuestion)
        : Result(totalScore: _totalScore, reset: _resetQuiz);
    return MaterialApp(
        home:
            Scaffold(appBar: AppBar(title: Text('My first app')), body: body));
  }
}
