import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            itemBuilder: (context, index) => Container(
                child: MessageBubble(
                    key: ValueKey(chatDocs?[index].id),
                    text: chatDocs?[index]['text'],
                    isMe: chatDocs?[index]['userId'] == FirebaseAuth.instance.currentUser!.uid,
                    username: chatDocs?[index]['username'],
                )),
            itemCount: chatDocs?.length ?? 0,
            reverse: true,
          );
        }
      },
    );
  }
}
