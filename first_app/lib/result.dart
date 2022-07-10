import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final VoidCallback reset;
  const Result({Key? key, required this.totalScore, required this.reset})
      : super(key: key);

  String get resultMessage {
    return 'You dit it! Score is $totalScore';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(
          resultMessage,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        TextButton(
          onPressed: reset,
          child: Text('Restart Quiz'),
          style: TextButton.styleFrom(backgroundColor: Colors.amber),
        )
      ],
    ));
  }
}
