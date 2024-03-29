import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String username;
  final String avatarUrl;

  const MessageBubble(
      {Key? key, required this.text, required this.isMe, required this.username, required this.avatarUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: !isMe ? const Radius.circular(0) : const Radius.circular(12),
                  bottomRight: !isMe ? const Radius.circular(12) : const Radius.circular(0),
                ),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
                    style: TextStyle(
                        color: isMe ? Colors.black87 : Theme.of(context).primaryTextTheme.displayLarge!.color),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
            top: 0,
            left: isMe ? null : 120,
            right: isMe? 120 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(avatarUrl),
            )),
      ],
    );
  }
}
