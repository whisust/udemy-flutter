import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String label;
  final Function selectHandler;

  Answer(this.label, this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.deepOrangeAccent),
          child: Text(label),
          onPressed: () {
            selectHandler();
          },
        ));
    // TODO: implement build
    throw UnimplementedError();
  }
}
