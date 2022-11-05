import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const AdaptiveFlatButton({Key? key, required this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(onPressed: onPressed, child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)))
        : ElevatedButton(
            onPressed: onPressed,
            child: const Text('Choose date', style: TextStyle(fontWeight: FontWeight.bold)),
          );
  }
}
