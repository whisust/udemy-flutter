import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          final chatDocs = snapshot.data?.docs;
          return ListView.builder(
            itemBuilder: (context, index) =>
                Container(child: MessageBubble(text: chatDocs?[index]['text'])),
            itemCount: chatDocs?.length ?? 0,
            reverse: true,
          );
        }
      },
    );
  }
}
