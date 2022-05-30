import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String question;

  const Question(this.question, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(50),
        child: Text(
          question,
          style: TextStyle(fontSize: 28),
          textAlign: TextAlign.center,
        ));
  }
}
