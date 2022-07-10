import 'question.dart';
import 'answer.dart';
import 'package:flutter/material.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  const Quiz({
    super.key,
    required this.questions,
    required this.questionIndex,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: question(questions.elementAt(questionIndex)));
  }

  List<Widget> question(Map<String, Object> question) {
    return [
      Question(question['question'] as String),
      ...(question['answers'] as List<Map<String, Object>>).map((answer) {
        return Answer(answer['text'] as String,
            () => answerQuestion(answer['score'] as int));
      })
    ];
  }
}
