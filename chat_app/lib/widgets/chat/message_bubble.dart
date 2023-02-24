import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String username;

  const MessageBubble({Key? key, required this.text, required this.isMe, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
              bottomRight: !isMe ? Radius.circular(12) : Radius.circular(0),
            ),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(username,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe ? Colors.black87 : Theme.of(context).primaryTextTheme.displayLarge!.color)),
              Text(
                text,
                textAlign: isMe ? TextAlign.end : TextAlign.start,
                style: TextStyle(color: isMe ? Colors.black87 : Theme.of(context).primaryTextTheme.displayLarge!.color),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
