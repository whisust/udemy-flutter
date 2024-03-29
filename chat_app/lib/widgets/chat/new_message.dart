import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String? _message;
  final _controller = TextEditingController();

  Future<void> _sendMessage() async {
    FocusScope.of(context).unfocus();
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    await FirebaseFirestore.instance.collection('chat').add({
      'text': _message,
      'createdAt': Timestamp.now(),
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'username': userData['username'],
      'avatarUrl': userData['avatarUrl'],
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send Message'),
              onChanged: (value) {
                setState(() {
                  _message = value;
                });
              },
            )),
            IconButton(
                onPressed: _message == null ? null : _sendMessage,
                icon: Icon(Icons.send),
                color: Theme.of(context).colorScheme.primary)
          ],
        ));
  }
}
