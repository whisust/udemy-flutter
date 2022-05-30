import 'package:flutter/material.dart';

import './question.dart';

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
  var questionIndex = 0;

  void switchToNext() {
    setState(() {
      questionIndex = (questionIndex + 1) % 2;
    });
  }

  List<Widget> question(String label) {
    return [
      Question(label),
      ElevatedButton(child: Text('A 1'), onPressed: switchToNext),
      ElevatedButton(child: Text('A 2'), onPressed: switchToNext),
      ElevatedButton(child: Text('A 3'), onPressed: switchToNext),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var questions = ['Fav animal?', 'Fav color?'];
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('My first app')),
            body: Column(
              children: question(questions.elementAt(questionIndex)),
            )));
  }
}
